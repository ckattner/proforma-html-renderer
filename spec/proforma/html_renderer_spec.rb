# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'rendering_helper'
require 'spec_helper'

describe Proforma::HtmlRenderer do
  specify 'snapshot has been un-modified' do
    snapshot_dir = File.expand_path(File.join(__dir__, '..', 'fixtures', 'snapshot'))
    rendering_helper = RenderingHelper.new(snapshot_dir)

    actual_output = rendering_helper.render.map.with_index do |output, index|
      [
        rendering_helper.output_filename(output, index),
        output.contents
      ]
    end.to_h

    output_glob = File.join(snapshot_dir, 'output', '*')

    expected_output = Dir[output_glob].map do |filename|
      [File.basename(filename), File.open(filename, 'rb').read]
    end.to_h

    expect(actual_output).to eq(expected_output)
  end
end
