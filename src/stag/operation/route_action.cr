# Parses the action from the CLI arguments and routes it to an Action.
class Stag::Operation::RouteAction < Stag::Operation::Base

  @arguments : Arguments
  @options   : Options
  @router    : Router

  def initialize(@arguments, @options, @router)
    setup_router
  end

  def call
    action_argument = @arguments.shift?

    @router.route(action_argument, @arguments, @options)
  end

  protected def setup_router
    @router.map(action: :index,   aliases: %w[index list],            to: Action::Index, default: true)
    @router.map(action: :create,  aliases: %w[create new],            to: Action::Create)
    @router.map(action: :read,    aliases: %w[read show view],        to: Action::Read)
    @router.map(action: :update,  aliases: %w[update edit],           to: Action::Update)
    @router.map(action: :destroy, aliases: %w[destroy delete remove], to: Action::Destroy)
  end

end

