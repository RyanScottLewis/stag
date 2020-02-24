class Stag::Action::Index < Stag::Action::Base

  def call
    query   = Query.preload([:unions, :tags])
    sources = Repository.all(Model::Source, query)

    puts Formatter::Index::Table.call(sources)
  end

end

