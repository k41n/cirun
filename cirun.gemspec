# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cirun/version"

Gem::Specification.new do |spec|
  spec.name          = "cirun"
  spec.version       = Cirun::VERSION
  spec.authors       = ["Andrei Malyshev"]
  spec.email         = ["Andrei.Malyshev@kodep.ru"]

  spec.summary       = %q{This gem allows fast launch tests against specific redmine/ruby/db combo}
  spec.homepage      = "https://redmineup.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
end
