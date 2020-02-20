#!/usr/bin/env ruby

require 'securerandom'

class Repository

  def initialize
    @records = []
    @index = {}
  end

  def find_by(key, value)
    return nil unless @index.key?(key) && @index[key].key?(value)

    index = @index[key][value]

    @records[index]
  end

  # Magic methods: #find_by_KEY(value)
  def method_missing(method, *arguments, &block)
    method = method.to_s
    raise NoMethodError unless method.start_with?('find_by')
    raise ArgumentError, 'Requires 1 arguments' unless arguments.length == 1

    key   = method.gsub(/^find_by_/, '').to_sym
    value = arguments.first

    find_by(key, value)
  end

  def store(item)
    item.id ||= SecureRandom.uuid

    index = @records.size

    item.class.indicies.each do |key|
      value = item.send(key)
      next if value.nil?
      @index[key] ||= {}
      @index[key][value] = index
    end

    @records << item
  end
  alias_method :<<, :store

  def to_a
    @records
  end

  def to_h
    {
      index:   @index,#.map(&:to_h),
      records: @records.map(&:to_h),
    }
  end

end

class Store < Hash

  def to_h
    each.with_object({}) do |(key, value), memo|
      memo[key] = value.to_h
    end
  end

end

AbstractModel = ->(store) do
  anonymous_class = Class.new do

    class_variable_set(:@@store, store)

    class << self

      def store
        class_variable_get(:@@store)
      end

      def repository_key # TODO: Use fast_underscore game?
        name.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').downcase.to_sym
      end

      def repository
        store[repository_key] ||= Repository.new
      end

      def properties
        @properties ||= []
      end

      def property(name, index: false)
        properties << name
        indicies << name if index
        attr_accessor(name)
      end

      def indicies
        @indicies ||= []
      end

      def index(name)
        indicies << name
      end

      def all
        repository.to_a
      end

      def create(**attributes)
        new.update(**attributes)
      end

      # Magic methods: #find_by_KEY(value)
      def method_missing(method, *arguments, &block)
        raise NoMethodError unless method.to_s.start_with?('find_by')

        repository.send(method, *arguments, &block)
      end

    end

    attr_accessor :id

    def update_attributes(**attributes)
      attributes.each do |key, value|
        send("#{key}=", value)
      end

      self
    end

    def save
      self.class.repository << self

      self
    end

    def update(**attributes)
      update_attributes(**attributes)
      save
    end

    def to_h
      hash = { id: id }

      self.class.properties.each.with_object(hash) do |property, memo|
        memo[property] = send(property)
      end
    end

  end
end


# TODO: Above should be replaced with a decent ORM
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

STORE = Store.new

class Model < AbstractModel[STORE]
end

class Link < Model

  property :name
  property :path, index: true # File system path
  property :tag_ids

end

class Tag < Model

  index :id

  property :name
  property :path, index: true # Tag hierarchy path
  property :level
  property :parent_id

  def parent
    self.class.find_by_id(parent_id)
  end

  def children
    Tag.all.select { |tag| tag.parent_id == id }
  end

  def links
    Link.all.select { |link| link.tag_ids.include?(id) }
  end

  def nodes
    children + links
  end

end

class Factory

  def self.create(**attributes)
    new.create(**attributes)
  end

  def create(**attributes)
    if attributes.key?(:tags) # Find or create each tag in the tag paths in a hierarchy
      tags = attributes.delete(:tags).map do |tag|
        partials = tag.gsub(/^\//, '').gsub(/\/+/, ?/).split(?/)

        deepest_tag = partials.each_with_index.inject(nil) do |parent, (partial, level)|
          parent_id = parent.nil? ? nil : parent.id
          path      = partials[0..level].join(?/)
          tag       = Tag.find_by_path(path)

          tag || Tag.create(name: partial, path: path, level: level, parent_id: parent_id)
        end
      end

      attributes[:tag_ids] = tags.map(&:id)
    end

    Link.create(attributes)
  end

end

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

class FileSystemOperation

  def initialize(node, source: nil, destination:)
    @node        = node
    @source      = source
    @destination = destination
  end

  def execute(dry: false)
    puts report

    message = "      \e[90m%s\e[0m" % command
    message << " \e[33m[DRY]\e[90m" if dry


    puts message
    system command unless dry
  end

  def command
    if @node.is_a?(Link)
      "ln -s '%s' '%s'" % [@source, @destination]
    elsif @node.is_a?(Tag)
      "mkdir -p '%s'" % @destination
    end
  end

  def report
    if @node.is_a?(Link)
      "\e[35mLINK:\e[0m %s \e[37m→\e[0m \e[35m%s\e[0m" % [@source, @destination]
    elsif @node.is_a?(Tag)
      "\e[36mDIR:\e[0m  %s" % @destination
    end
  end

end

def generate_operations(node, path: nil, memo: [], root: '')
  root = '' if root == ?/
  root.gsub!(/\/+$/, '')

  source, destination = nil, nil

  if node.is_a?(Link)
    source      = node.path
    destination = [root, path, node.name].compact.join(?/)

    memo << FileSystemOperation.new(node, source: source, destination: destination)
  elsif node.is_a?(Tag)
    destination = [root, path, node.name].compact.join(?/)

    memo << FileSystemOperation.new(node, destination: destination)

    node.nodes.sort_by(&:name).each do |child|
      generate_operations(child, path: node.path, memo: memo, root: root)
    end
  end

  memo
end

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

Factory.create(name: 'MCU Project',     path: '/home/ryguy/projects/mcu_project', tags: %w[Programming/Projects Electrical/Projects])
Factory.create(name: 'Game Project',    path: '/home/ryguy/projects/game',        tags: %w[Programming/Projects Art/Design/Game])
Factory.create(name: 'RasPi Project',   path: '/home/ryguy/projects/raspi',       tags: %w[Electrical/Projects Programming/Linux])
Factory.create(name: 'Large Project A', path: '/home/ryguy/projects/large',       tags: %w[Programming/Projects/Large-Project])
Factory.create(name: 'Large Project B', path: '/home/ryguy/projects/large',       tags: %w[Programming/Projects/Large-Project])

require 'optparse'

OPTIONS = {
  root: '/'
}

option_parser = OptionParser.new do |options|
  options.banner = "Usage: tagln [options]"

  options.on("-h", "--help", "Show help") { |value| OPTIONS[:help] = value }
  options.on("-v", "--[no-]verbose", "Run verbosely") { |value| OPTIONS[:verbose] = value }
  options.on("-d", "--dry", "Run without making changes") { |value| OPTIONS[:dry] = value }
  options.on("-D", "--debug", "Show debug information") { |value| OPTIONS[:debug] = value }
  options.on("-r", "--root=value", "Root path for generating tag filesystem") { |value| OPTIONS[:root] = value }
end

option_parser.parse!

if OPTIONS[:help]
  puts option_parser
  exit
end

if OPTIONS[:debug]

  puts "\nStore:\n\n"
  pp STORE.to_h
  puts

  puts "\nOptions:\n\n"
  pp OPTIONS.to_h
  puts

  exit
end

root       = OPTIONS[:root]
tags       = Tag.all.select { |tag| tag.level == 0 }.sort_by(&:name)
operations = tags.map { |tag| generate_operations(tag, root: root) }.flatten

operations.each { |operation| operation.execute(dry: OPTIONS[:dry]) }

__END__

TODO:

  # Destructive tasks: Root is compared to the outputs of current FS operations and only the changes are applied

  $ fstag add --path some/path Some/Tag Another/Tag # Add some tags to the given path
  $ fstag add Some/Tag Another/Tag                  # Path is assumed to be `pwd`
  $ fstag delete Some/Tag                           # Delete given tag(s) from current path
  $ fstag sync[chronize]                            # Sync the virtual "fs" with the fs

  # Non-destructive tasks

  $ fstag list Some/Tag                             # List all paths for given tag(s)
  $ fstag list --path some/path                     # List all tags for given path

