require 'uuid'

class LogMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    correlation_id = request.env['HTTP_CID'] || "cid-#{UUID.new.generate}"
    Thread.current[:cid] = correlation_id
    SemanticLogger.tagged(correlation_id) do
      @app.logger.info(mensaje_log_recibido(request))

      status, headers, response = @app.call(env)

      @app.logger.info(mensaje_log_enviado(status, headers, response))

      [status, headers, response]
    end
  end

  private

  def mensaje_log_recibido(request)
    "Request: #{request.request_method} #{request.url}\nBody: #{request.body.read}"
  end

  def mensaje_log_enviado(status, headers, response)
    "Response: Status: #{status} Headers: #{headers} Response: #{response}"
  end
end
