# frozen_string_literal: true

module ActsAsReactable
  module Reactable
    def self.included(base)
      base.extend(ClassMethod)
    end

    module ClassMethod
      def acts_as_reactor
        has_many :reactions, as: :reactor
      end
    end
  end
end