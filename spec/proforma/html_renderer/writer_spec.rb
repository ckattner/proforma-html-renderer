# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe Proforma::HtmlRenderer::Writer do
  let(:intro_name) { 'example.txt.erb' }
  let(:aloha_name) { 'aloha.txt.erb' }

  let(:intro_template) { 'My name is <%= first_name %>' }

  subject do
    described_class.new(
      directory: File.join(__dir__, '..', '..', 'fixtures'),
      files: { intro_name => intro_template }
    )
  end

  describe '#initialize with no arguments' do
    it 'should set directory to this libraries template dir' do
      actual    = File.expand_path(described_class.new.send(:directory))
      expected  = File.expand_path(File.join(__dir__, '..', '..', '..', 'templates'))

      expect(actual).to eq(expected)
    end
  end

  context 'when using cached files' do
    it 'renders ERB template' do
      expected = 'My name is Earl'

      expect(subject.render(intro_name, first_name: 'Earl')).to eq(expected)
    end
  end

  context 'when not using cached files' do
    it 'renders ERB template' do
      expected = 'Aloha, Matty Cakes!'

      expect(subject.render(aloha_name, full_name: 'Matty Cakes')).to eq(expected)
    end
  end
end
