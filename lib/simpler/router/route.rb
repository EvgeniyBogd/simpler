module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @params = {}

      end

      def match?(method, path)
        @method == method && set_params(path)
      end

    private
 
      def set_params(path)
        path_element = path.split('/').reject!(&:empty?)
        request_element = @path.split('/').reject!(&:empty?)
        
        return false if path_element.size != request_element.size

        path_element.each_with_index do |element, index|
          if element.start_with?(':')
            @params[element] = request_element[index]
          end  
        end
        
        
      end  
    end
  end
end
