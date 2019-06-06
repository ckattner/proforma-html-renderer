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
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.homepage    = 'https://github.com/bluemarblepayroll/proforma-html-renderer'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.3.8'

  s.add_dependency('proforma', '~>1')

  s.add_development_dependency('guard-rspec', '~>4.7')
  s.add_development_dependency('pry', '~>0')
  s.add_development_dependency('pry-byebug', '~> 3')
  s.add_development_dependency('rake', '~> 10.0')
  s.add_development_dependency('rspec', '~> 3.8')
  s.add_development_dependency('rubocop', '~>0.63.1')
  s.add_development_dependency('simplecov', '~>0.16.1')
  s.add_development_dependency('simplecov-console', '~>0.4.2')
end
