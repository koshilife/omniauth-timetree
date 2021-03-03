# frozen_string_literal: true

require_relative 'lib/omniauth-timetree/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-timetree'
  spec.version       = OmniAuth::TimeTree::VERSION
  spec.authors       = ['Kenji Koshikawa']
  spec.email         = ['koshikawa2009@gmail.com']

  spec.summary       = 'OmniAuth strategy for TimeTree'
  spec.description   = spec.description
  spec.homepage      = 'https://github.com/koshilife/omniauth-timetree'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/koshilife/omniauth-timetree'
  spec.metadata['changelog_uri'] = "#{spec.metadata['source_code_uri']}/blob/master/CHANGELOG.md"
  spec.metadata['documentation_uri'] = "https://www.rubydoc.info/gems/omniauth-timetree/#{spec.version}"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'omniauth', '~> 1.9'
  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.6.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'codecov'
  spec.add_development_dependency 'omniauth'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'
end
