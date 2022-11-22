# frozen_string_literal: true

require 'logger'

class SimplerLogger

  def initialize(**options)
    @logger = Logger.new(options[:logdev] || $stdout)
  end

  def write_log(message)
    @logger.info(message)
  end

  def log(params)
    write_log(build_log(params))
  end

  private

  def build_log(params)
    "\n#{params.join("\n")}"
  end
end
