# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'base64'
require 'erb'
require 'forwardable'
require 'ostruct'
require 'proforma'

require_relative 'html_renderer/proforma_writer'

module Proforma
  # This main class to use as a Proforma renderer.
  class HtmlRenderer
    EXTENSION = '.html'

    DEFAULT_OPTIONS = {
      bold_weight: 'bold',
      font_family: 'sans-serif',
      header_font_size: 18,
      line_height_increase: 5,
      text_font_size: 13
    }.freeze

    attr_reader :options

    def initialize(options = {})
      @options = OpenStruct.new(DEFAULT_OPTIONS.merge(options))
    end

    def render(prototype)
      contents = ProformaWriter.render(prototype, options)

      Proforma::Document.new(
        contents: contents,
        extension: EXTENSION,
        title: prototype.title
      )
    end
  end
end
