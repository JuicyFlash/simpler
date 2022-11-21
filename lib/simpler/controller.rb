require_relative 'view'

module Simpler
  class Controller

    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action
      @request.env['simpler.status'] = 200

      set_default_headers
      send(action)
      write_response

      @response.finish
    end

    def make_404_response
      set_404_headers
      @request.env['simpler.status'] = 404
      @request.env['simpler.template'] = '404'
      @response.status = 404
      write_response
      @response.finish
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_404_headers
      set_default_headers
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def params
      @request.params
    end

    def render(template)
      @request.env['simpler.template'] = template
      @request.env['simpler.format'] = template if template.is_a?(Hash)
    end

    def status(status)
      @response.status = status
    end

    def headers
      @response
    end

  end
end
