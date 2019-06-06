# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  class HtmlRenderer
    # This class can render ERB templates.
    class Writer
      # This nested class is an internal intermediate only used by the encapsulating Writer class.
      # It is simply used to convert an OpenStruct object to a Binding object which can be used
      # for ERB template rendering.
      class ErbBinding < OpenStruct
        def expose_binding
          binding
        end
      end

      BACK_DIR      = '..'
      ERB_OPTIONS   = '-'
      TEMPLATE_DIR  = 'templates'

      def initialize(directory: nil, files: {})
        @directory  = directory || default_directory
        @files      = to_erb_hash(files)
      end

      def render(name, context = {})
        erb_template(name).result(hash_to_binding(context))
      end

      private

      attr_reader :directory, :files

      def hash_to_binding(hash)
        ErbBinding.new(hash).expose_binding
      end

      def erb_template(name)
        files[name.to_s] ||= read(name)
      end

      def read(name)
        text = IO.read(path(name)).chop
        ERB.new(text, nil, ERB_OPTIONS)
      end

      def default_directory
        File.join(
          __dir__,
          BACK_DIR,
          BACK_DIR,
          BACK_DIR,
          TEMPLATE_DIR
        )
      end

      def path(name)
        File.join(directory, name.to_s)
      end

      def to_erb_hash(hash)
        (hash || {}).map do |(name, file)|
          [
            name.to_s,
            file.is_a?(ERB) ? file : ERB.new(file)
          ]
        end.to_h
      end
    end
  end
end
