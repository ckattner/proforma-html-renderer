# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'object_writer'

module Proforma
  class HtmlRenderer
    # This class connects each Proforma object to its proper template for rendering.
    class ProformaWriter
      extend Forwardable

      # The singleton is provided as a global helper since we want to expose the same
      # static functionality across the entire app.  The real value is the caching of the
      # Writer's files so we are only reading each template the initial time.
      class << self
        extend Forwardable

        def_delegators :instance, :render

        def instance
          @instance ||= new
        end
      end

      NAMES_BY_CLASS = {
        Modeling::Banner => 'banner.html.erb',
        Modeling::Header => 'header.html.erb',
        Modeling::Pane => 'pane.html.erb',
        Modeling::Separator => 'separator.html.erb',
        Modeling::Spacer => 'spacer.html.erb',
        Modeling::Table => 'table.html.erb',
        Modeling::Text => 'text.html.erb',
        Prototype => 'prototype.html.erb'
      }.freeze

      attr_reader :object_writer

      def_delegators :object_writer, :render

      def initialize(object_writer: ObjectWriter.new(names_by_class: NAMES_BY_CLASS))
        @object_writer = object_writer
      end
    end
  end
end
