require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze
    VIEW404_BASE_PATH = 'public'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      return @env['simpler.format'][:plain] unless @env['simpler.format'].nil?

      template = File.read(template_path)
      return template if @env['simpler.status'] == 404

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

    def template_path
      path = template || [controller.name, action].join('/')

      return Simpler.root.join(VIEW404_BASE_PATH, "#{path}.html") if @env['simpler.status'] == 404

      Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
    end

  end
end
