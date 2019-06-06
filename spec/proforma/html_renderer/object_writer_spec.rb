# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe Proforma::HtmlRenderer::ObjectWriter do
  let(:string_name) { 'string.txt.erb' }

  let(:string_template) { 'String Value: <%= object %>' }

  let(:writer) do
    Proforma::HtmlRenderer::Writer.new(
      files: { string_name => string_template }
    )
  end

  subject do
    described_class.new(
      names_by_class: {
        String => 'string.txt.erb'
      },
      writer: writer
    )
  end

  context 'when using cached files' do
    it 'renders template for String object' do
      object = 'ABC123'
      expected = "String Value: #{object}"

      expect(subject.render(object)).to eq(expected)
    end
  end
end
