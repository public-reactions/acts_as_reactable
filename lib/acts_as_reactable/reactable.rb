# frozen_string_literal: true

module ActsAsReactable
  module Reactable
    def self.included(base)
      base.extend(ClassMethod)
    end

    module ClassMethod
      def acts_as_reactable
        has_many :reactions, class_name: "ActsAsReactable::Reaction", as: :reactable, dependent: :delete_all

        define_method :destroy_reaction_from do |reactor|
          raise "InvalidReactor" if !reactor

          puts reaction = reactions.find_by(reactor: reactor)
          return unless (reaction = reactions.find_by(reactor: reactor))
          reaction.destroy
        end

        define_method :update_reaction_from do |reactor, emoji = nil|
          raise "InvalidReactor" if !reactor

          if !emoji
            return destroy_reaction_from(reactor)
          end

          reaction = reactions.where({reactor: reactor, emoji: emoji}).first_or_create
          reaction
        end

        define_method :remove_reactions do |reactor, emoji_or_list = nil|
          return unless emoji_or_list

          emojis =  if emoji_or_list.is_a?(Array)
                      emoji_or_list
                    else
                      [emoji_or_list]
                    end

          reactions
            .where(reactor: reactor, emoji: emojis.compact.uniq)
            .destroy_all

          self
        end
      end
    end
  end
end
