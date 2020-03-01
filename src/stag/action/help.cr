class Stag::Action::Help < Stag::Action::Base

  def call
    action_name = (@cli.arguments.first? || "global").strip.downcase

    # TODO: There is where the router helper function would go... IF I HAD ONE
    # This really needs to change
    key = case action_name
    when "index", "list" then :index
    when "read", "show", "view" then :read
    when "sync", "synchronize" then :synchronize
    else; :global
    end

    puts @cli.option_parsers[key]
  end

end

