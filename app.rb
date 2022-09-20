require_relative 'time_formatter'

class App

  def call(env)
    request = Rack::Request.new env
    params = request.params["format"]

    if request.path == '/time' && params != nil
      formatter = TimeFormatter.new(params)

      if formatter.success?
        [ 200,
          { 'content-type' => 'text/plain' },
          [ "Format: #{ formatter.formatted_time }\n" ] ]
      else
        [ 400,
          { 'content-type' => 'text/plain' },
          [ "Unknown time format #{ formatter.unknown_formats }\n" ] ]
      end
    else
      [ 404, {}, [ "Page Not Found\n" ] ]
    end
  end
end
