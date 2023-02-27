require 'rack'

class Logger

  def initialize(app)
    @app = app
  end
  
  def call(env)
    request = Rack::Request.new(env)
    status, headers, body = @app.call(env)
    method = request.request_method
    url = request.url
    params = request.params
    controller = env['simpler.controller']
    action = env['simpler.action']

    log("Request: #{method} #{url}")
    log("Handler: #{controller.class.name}##{action}")
    log("Parameters: #{params}")
  
    content_type = headers['Content-Type']
    log("Response: #{status} #{Rack::Utils::HTTP_STATUS_CODES[status]} [#{content_type}] #{headers}")
    
    [status, headers, body]
  end
  
  def log(message)
    file = File.open('log/app.log', 'a')
    file.puts("#{message}")
    file.close
  end  

end    