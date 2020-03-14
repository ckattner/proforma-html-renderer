# frozen_string_literal: true

require './lib/proforma/html_renderer/version'

Gem::Specification.new do |s|
  s.name        = 'proforma-html-renderer'
  s.version     = Proforma::HtmlRenderer::VERSION
  s.summary     = 'Proforma renderer plugin for generating HTML.'

  s.description = <<-DESCRIPTION
    Proforma is a virtual document object model.  This library allows you to output HTML for a virtual Proforma document.
  DESCRIPTION

  s.authors     = ['Matthew Ruggio']
  s.email       = ['mruggio@bluemarblepayroll.com']
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.bindir      = 'exe'
  s.executables = %w[]
  s.homepage    = 'https://github.com/bluemarblepayroll/proforma-html-renderer'
  s.license     = 'MIT'
  s.metadata    = {
    'bug_tracker_uri' => 'https://github.com/bluemarblepayroll/proforma-html-renderer/issues',
    'changelog_uri' => 'https://github.com/bluemarblepayroll/proforma-html-renderer/blob/master/CHANGELOG.md',
    'documentation_uri' => 'https://www.rubydoc.info/gems/proforma-html-renderer',
    'homepage_uri' => s.homepage,
    'source_code_uri' => s.homepage
  }

  s.required_ruby_version = '>= 2.3.8'

  s.add_dependency('proforma', '~>1')

  s.add_development_dependency('guard-rspec', '~>4.7')
  s.add_development_dependency('pry', '~>0')
  s.add_development_dependency('rake', '~> 13.0')
  s.add_development_dependency('rspec', '~> 3.8')
  s.add_development_dependency('rubocop', '~>0.79.0')
  s.add_development_dependency('simplecov', '~>0.17.0')
  s.add_development_dependency('simplecov-console', '~>0.6.0')
end
