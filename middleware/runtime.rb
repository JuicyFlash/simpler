# frozen_string_literal: true
require_relative 'simpler_logger'

class Runtime

  def initialize(app)
    @app = app
    @logger = SimplerLogger.new(logdev: "#{File.expand_path('..', __dir__)}/log/app.log")
  end

  def call(env)
    status, headers, body = @app.call(env)

    request = "Request: #{env['REQUEST_METHOD']} #{env['REQUEST_URI']}"
    handler = "Handler: #{env['simpler.handler']}"
    parameters = "Parameters: #{env['simpler.params']}"
    response = "Response: #{status} [#{headers['Content-Type']}] #{env['simpler.template_path']}"
    @logger.log([request, handler, parameters, response])
    [status, headers, body]
  end
end
