# frozen_string_literal: true

require_relative 'lib/validates_identity/version'

Gem::Specification.new do |spec|
  spec.name = 'validates_identity'
  spec.version = ValidatesIdentity::VERSION
  spec.authors = ['Paulo Ribeiro']
  spec.email = ['plribeiro3000@gmail.com']

  spec.summary = 'Validates Several Identity Documents and test it with matchers in a simple way.'
  spec.homepage = 'https://github.com/plribeiro3000/validates_identity'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/plribeiro3000/validates_identity/blob/master'
  spec.metadata['changelog_uri'] = 'https://github.com/plribeiro3000/validates_identity/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activemodel'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
