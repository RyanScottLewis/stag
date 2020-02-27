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

  def route(action_name : String?, arguments : Arguments, options : Options)
    route = if action_name.nil?
      @default_route
    else
      @routes.select { |route| route[:aliases].includes?(action_name) }[0]?
    end

    if route.nil?
      raise "Unknown route" # TODO: Just return nil orrr?
    else
      route[:to].call(arguments, options)
    end
  end

end

