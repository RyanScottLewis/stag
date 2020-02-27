# Action router.
class Stag::Router

  @default_route : Route?
  @routes = [] of Route

  def initialize
  end

  def map(action : Symbol, to : Action::Base.class, aliases = [] of String, default = false)
    route = Route.new(action: action, to: to, aliases: aliases, default: default)
    @routes << route
    @default_route = route if default

    route
  end

  def route_for?(action_name : String?)
    if action_name.nil?
      @default_route
    else
      @routes.select { |route| route[:aliases].includes?(action_name) }[0]?
    end
  end

  def route_for(action_name : String?)
    route_for?(action_name).not_nil!
  end

  def route(action_name : String?, arguments : Arguments, options : Options::Global)
    route = route_for(action_name)

    route[:to].call(arguments, options)
  end

end

