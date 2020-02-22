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

  def route(action_name : String?)
    route = if action_name.nil?
      @default_route
    else
      @routes.select { |route| route[:aliases].includes?(action_name) }[0]?
    end

    if route.nil?
      # TODO: Run help action or something
    else
      route[:to].call
    end
  end

end

