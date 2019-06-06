# Proforma HTML Renderer

[![Gem Version](https://badge.fury.io/rb/proforma-html-renderer.svg)](https://badge.fury.io/rb/proforma-html-renderer) [![Build Status](https://travis-ci.org/bluemarblepayroll/proforma-html-renderer.svg?branch=master)](https://travis-ci.org/bluemarblepayroll/proforma-html-renderer) [![Maintainability](https://api.codeclimate.com/v1/badges/ea2b788b45fcc7d0a183/maintainability)](https://codeclimate.com/github/bluemarblepayroll/proforma-html-renderer/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/ea2b788b45fcc7d0a183/test_coverage)](https://codeclimate.com/github/bluemarblepayroll/proforma-html-renderer/test_coverage) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

[Proforma](https://github.com/bluemarblepayroll/proforma) ships with a basic plain-text renderer.  Luckily we can plug in different rendering engines to provide additional business value.  This library gives Proforma the ability to render HTML instead of simple plain-text.

## Installation

To install through Rubygems:

````
gem install install proforma-html-renderer
````

You can also add this to your Gemfile:

````
bundle add proforma-html-renderer
````

Note: If you are using bundler for auto-requiring then you need to specify as:

```
gem 'proforma-html-renderer', require: 'proforma/html_renderer'
```

## Examples

### Connecting to Proforma Rendering Pipeline

To use this plugin within Proforma:

1. Install [Proforma](https://github.com/bluemarblepayroll/proforma)
2. Install this library
3. Require both libraries
4. Pass in an instance of Proforma::HtmlRenderer into the Proforma#render method

````ruby
require 'proforma'
require 'proforma/html_renderer'

data = [
  { id: 1, name: 'Chicago Bulls' },
  { id: 2, name: 'Indiana Pacers' },
  { id: 3, name: 'Boston Celtics' }
]

template = {
  title: 'nba_team_list',
  children: [
    { type: 'Header', value: 'NBA Teams' },
    { type: 'Separator' },
    {
      type: 'DataTable',
      columns: [
        { header: 'Team ID #', body: '$id' },
        { header: 'Team Name', body: '$name' },
      ]
    }
  ]
}

documents = Proforma.render(data, template, renderer: Proforma::HtmlRenderer.new)
````

The `documents` attribute will now be an array with one object:

```ruby
expected_documents = [
  {
    contents: "...", # HTML Data
    extension: '.html',
    title: 'nba_team_list'
  }
]
```

The `contents` attribute will contain the HTML.

### Customization

All options are passed into Proforma::HtmlRenderer#initialize as a hash:

Name                 | Default
-------------------- | -------
bold_weight          | bold
font_family          | sans-serif
header_font_size     | 18
line_height_increase | 5
text_font_size       | 13

These options will be used during the rendering process.

## Contributing

### Development Environment Configuration

Basic steps to take to get this repository compiling:

1. Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (check proforma-html-renderer.gemspec for versions supported)
2. Install bundler (gem install bundler)
3. Clone the repository (git clone git@github.com:bluemarblepayroll/proforma-html-renderer.git)
4. Navigate to the root folder (cd proforma)
5. Install dependencies (bundle)

### Running Tests

To execute the test suite run:

````
bundle exec rspec spec --format documentation
````

Alternatively, you can have Guard watch for changes:

````
bundle exec guard
````

Also, do not forget to run Rubocop:

````
bundle exec rubocop
````

### Publishing

Note: ensure you have proper authorization before trying to publish new versions.

After code changes have successfully gone through the Pull Request review process then the following steps should be followed for publishing new versions:

1. Merge Pull Request into master
2. Update `lib/proforma/html_renderer/version.rb` using [semantic versioning](https://semver.org/)
3. Install dependencies: `bundle`
4. Update `CHANGELOG.md` with release notes
5. Commit & push master to remote and ensure CI builds master successfully
6. Run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

This project is MIT Licensed.
