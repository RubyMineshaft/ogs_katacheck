require_relative 'lib/ogs_katacheck/version'

Gem::Specification.new do |spec|
  spec.name          = "ogs_katacheck"
  spec.version       = OGSKataCheck::VERSION
  spec.authors       = ["RubyMineshaft"]
  spec.email         = ["rubymineshaft@online-go.com"]

  spec.summary       = %q{CLI that checks user submitted moves against AI game reviews.}
  spec.description   = %q{This CLI gem is written for OGS team members in order to aid in investigating suspicions of botting.}
  spec.homepage      = "https://github.com/RubyMineshaft/ogs_katacheck"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/RubyMineshaft/ogs_katacheck/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ["ogs-katacheck", "katacheck"]
  spec.require_paths = ["lib"]
end
