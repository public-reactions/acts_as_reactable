# frozen_string_literal: true

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib")

require "sqlite3"
require "simplecov"
require "simplecov-cobertura"
require "factory_bot"
require "acts_as_reactable"

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
SimpleCov.start

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveRecord::Schema.define(version: 1) do
  create_table :users do |t|
    t.timestamps
  end

  create_table :posts do |t|
    t.references :user, foreign_key: true
    t.timestamps
  end

  create_table :reactions do |t|
    t.references :reactable, polymorphic: true, null: false
    t.references :reactor, polymorphic: true, null: false

    t.string :emoji, null: false, index: true

    t.timestamps
  end
end

class User < ActiveRecord::Base
  has_many :posts

  acts_as_reactor
end

class Post < ActiveRecord::Base
  belongs_to :user

  acts_as_reactable
end
