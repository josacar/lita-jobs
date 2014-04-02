Gem::Specification.new do |spec|
  spec.name          = "lita-jobs"
  spec.version       = "0.0.1"
  spec.authors       = ["Jose Luis Salas"]
  spec.email         = ["josacar@gmail.com"]
  spec.description   = %q{Run jobs in lita}
  spec.summary       = %q{Spawn and control deferred jobs in lita}
  spec.homepage      = "https://github.com/josacar/lita-jobs"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 3.0"
  spec.add_runtime_dependency "eventmachine"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0.0.beta2"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
end
