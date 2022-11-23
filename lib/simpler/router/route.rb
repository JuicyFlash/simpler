module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :parameter, :path

      def initialize(method, path, controller, action)
        @method = method
        @parameter = param(path)
        @path = if @parameter.empty?
                  path
                else
                  path.gsub("/#{@parameter}", '').to_s
                end
        @controller = controller
        @action = action
      end

      def match?(method, path)
        return @method == method.to_sym && path.match?(reg_exp_path(full_path, @parameter)) unless @parameter.empty?

        @method == method.to_sym && path == full_path
      end

      private

      def param(path)
        path.match(/:[a-zA-Z]+/).to_s
      end

      def reg_exp_path(path, param)
        /#{path.gsub(param, '[0-9]+')}/
      end

      def full_path
        return "#{@path}/#{@parameter}" unless @parameter.empty?

        @path
      end
    end
  end
end
