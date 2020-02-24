module Stag::Concern::ClassCallable

  module ClassMethods

    def call(*arguments)
      new(*arguments).call
    end

  end

  macro included

    extend ClassMethods

  end

  # TODO: Make NOT abstract since most classes which use this module are abstract,
  # forcing them to define empty #call methods.
  abstract def call

end

