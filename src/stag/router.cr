# Action router.
class Stag::Router

  @default_route : Route?
  @routes = [] of Route

  def initialize
    yield self
  end

  def map(aliases : Array(String), action : Action::Base.class, default = false)
    route = Route.new(action: action, aliases: aliases, default: default)
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

  def route(action_name : String?, cli : Interface::CLI)
    route = route_for(action_name)

    route[:action].call(cli)
  end

end

