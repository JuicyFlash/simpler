require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze
    VIEW404_BASE_PATH = 'public'.freeze

    def initialize(env)
      @env = env
      write_template_path
    end

    def render(binding)
      return format[:plain] unless format.nil?

      template = File.read(template_path)
      return template if status == 404

       ERB.new(template).result(binding)
    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end

    def format
      @env['simpler.format']
    end

    def write_template_path
      return @env['simpler.template_path'] = "#{template || [controller.name, action].join('/')}.html" if status == 404

      @env['simpler.template_path'] = if format.nil?
                                        "#{template || [controller.name, action].join('/')}.html.erb"
                                      else
                                        format[:plain]
                                      end
    end

    def status
      @env['simpler.status']
    end

    def template_path
      path = template || [controller.name, action].join('/')

      return Simpler.root.join(VIEW404_BASE_PATH, "#{path}.html") if status == 404

      Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
    end

  end
end
