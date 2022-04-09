require "unicode/emoji"

module ActsAsReactable
  class Reaction < ::ActiveRecord::Base
    belongs_to :reactable, polymorphic: true
    belongs_to :reactor, polymorphic: true

    validates_presence_of :reactable_id
    validates_presence_of :reactor_id
    validates_format_of :emoji, with: Unicode::Emoji::REGEX
  end
end
