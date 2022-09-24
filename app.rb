require_relative 'time_formatter'

class App

  def call(env)
    request = Rack::Request.new env
    params = request.params["format"]

    if request.path == '/time' && params != nil
      formatter = TimeFormatter.new(params)
      formatter.call
      formatter_response(formatter)
    else
      response(404, {}, [ "Page Not Found\n" ])
    end
  end

  private

  def response(status, headers, body)
    [ status, headers, body ]
  end

  def formatter_response(formatter)
    if formatter.success?
      response(200,
               { 'content-type' => 'text/plain' },
               [ "Format: #{ formatter.formatted_time }\n" ])
    else
      response(400,
               { 'content-type' => 'text/plain' },
               [ "Unknown time format: #{ formatter.unknown_formats }\n" ])
    end
  end
end
