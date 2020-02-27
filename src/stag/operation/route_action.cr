# Parses the action from the CLI arguments and routes it to an Action.
class Stag::Operation::RouteAction < Stag::Operation::Base

  @cli       : Interface::CLI
  @arguments : Arguments
  @router    : Router

  def initialize(@cli)
    @arguments = @cli.arguments
    @router    = @cli.router
  end

  def call
    action_argument = @arguments.shift?

    @router.route(action_argument, @cli)
  end

end

