# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'writer'

module Proforma
  class HtmlRenderer
    # Each object should have its own ERB template.  This class understands the connection of
    # objects and templates and knows how to render the template for the respective object
    # passed in.
    class ObjectWriter
      attr_reader :names_by_class, :writer

      def initialize(names_by_class: {}, writer: Writer.new)
        @names_by_class = names_by_class
        @writer         = writer
      end

      def render(object, options = {})
        writer.render(
          resolve_name(object),
          object: object,
          options: options
        )
      end

      private

      def resolve_name(object)
        names_by_class[object.class].tap do |name|
          raise ArgumentError, "object cannot be rendered: #{object.class}" unless name
        end
      end
    end
  end
end
