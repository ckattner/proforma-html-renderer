# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require './lib/proforma/html_renderer'

# This class can render based on a conventional directory structure of input files.
class RenderingHelper
  class << self
    def folders(path)
      Dir.entries(path).select do |entry|
        File.directory?(File.join(path, entry)) && !%w[. ..].include?(entry)
      end
    end
  end

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def render
    images    = images_hash(images_dir)
    config    = yaml_read(config_filename)
    data      = data_merge(config['data'], images)
    template  = config['template']  || {}
    evaluator = config['evaluator'] || Proforma::HashEvaluator.new
    renderer  = config['renderer']  || Proforma::HtmlRenderer.new

    Proforma.render(
      data,
      template,
      evaluator: evaluator,
      renderer: renderer
    )
  end

  def render_and_save
    output_dir = File.join(path, 'output')

    FileUtils.mkdir_p(output_dir)

    render.each_with_index do |output, index|
      name = output_filename(output, index)
      full_path = File.join(output_dir, name)

      IO.write(full_path, output.contents)
    end
  end

  def output_filename(output, index)
    name_without_extension = [
      index.to_s,
      output.title.to_s
    ].reject(&:empty?).join('.')

    "#{name_without_extension}#{output.extension}"
  end

  private

  def images_dir
    File.join(path, 'images')
  end

  def config_filename
    File.join(path, 'config.yml')
  end

  def yaml_read(file)
    YAML.safe_load(File.open(file))
  end

  def data_merge(data, hash)
    if data.is_a?(Array)
      data.map do |record|
        record.merge(hash)
      end
    elsif data.is_a?(Hash)
      data.merge(hash)
    end
  end

  def images_hash(path)
    images_glob = File.join(path, '*')

    Dir[images_glob].map do |image_filename|
      key = File.basename(image_filename, File.extname(image_filename))
      [key, File.open(image_filename, 'rb')]
    end.to_h
  end
end
