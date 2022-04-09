# frozen_string_literal: true

require_relative "lib/acts_as_reactable/version"

Gem::Specification.new do |spec|
  spec.name = "acts_as_reactable"
  spec.version = ActsAsReactable::VERSION
  spec.authors = ["Nami.W"]
  spec.email = ["todo@fake.mail"]

  spec.summary = "Emoji reactions for ActiveRecord models"
  spec.description = "Emoji reactions for ActiveRecord models"
  spec.homepage = "https://todo.fake.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activerecord", [">= 6.0"]
  spec.add_runtime_dependency "unicode-emoji", "~> 3.1"

  spec.add_development_dependency "rspec", "~> 3.11"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "standard", "~> 1.3"
  spec.add_development_dependency "rspec-rails", "~> 5.0"
  spec.add_development_dependency "factory_bot", "~> 6.0"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "simplecov"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
