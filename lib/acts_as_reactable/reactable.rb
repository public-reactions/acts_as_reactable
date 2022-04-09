# frozen_string_literal: true

module ActsAsReactable
  module Reactable
    def self.included(base)
      base.extend(ClassMethod)
    end

    module ClassMethod
      def acts_as_reactable
        has_many :reactions, class_name: "ActsAsReactable::Reaction", as: :reactable, dependent: :delete_all

        define_method :update_reaction_from do |reactor, emoji|
          reaction = reactions.find_or_initialize_by(reactor: reactor)
          reaction.emoji = emoji
          reaction.save
        end
      end
    end
  end
end
