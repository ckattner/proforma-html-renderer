# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe Proforma::HtmlRenderer::ProformaWriter do
  it 'should provide a singleton instance' do
    first_call = described_class.instance
    second_call = described_class.instance

    expect(first_call).to eq(second_call)
  end
end
