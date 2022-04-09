# frozen_string_literal: true

module ActsAsReactable
  module Reactable
    def self.included(base)
      base.extend(ClassMethod)
    end

    module ClassMethod
      def acts_as_reactor
        has_many :reactions, class_name: "ActsAsReactable::Reaction", as: :reactor, dependent: :delete_all
      end
    end
  end
end
