require "unicode/emoji"

module ActsAsReactable
  class Reaction < ::ActiveRecord::Base
    belongs_to :reactable, polymorphic: true
    belongs_to :reactor, polymorphic: true

    validates_format_of :emoji, with: Unicode::Emoji::REGEX
  end
end
