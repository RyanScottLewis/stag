module Stag::Concern::ClassCallable

  module ClassMethods

    def call(*arguments)
      new(*arguments).call
    end

  end

  macro included

    extend ClassMethods

  end

  abstract def call

end

