# frozen_string_literal: true

require "active_record"

require_relative "acts_as_reactable/version"
require_relative "acts_as_reactable/reaction"
require_relative "acts_as_reactable/reactable"
require_relative "acts_as_reactable/reactor"

ActiveSupport.on_load(:active_record) do
  include ActsAsReactable::Reactable
end
