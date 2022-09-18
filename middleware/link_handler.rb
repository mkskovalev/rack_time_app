class LinkHandler

  @@formats = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }

  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new env

    status, headers, body = @app.call(env)

    request_params = request.params["format"]

    unless request_params.nil?
      separator = request_params[/\W|[_]/]
      formats_from_url = request_params.split(separator)
      checked_formats = check_formats(formats_from_url)
      error_response = [ 400,
                         { },
                         [ "Unknown time format #{ checked_formats }\n" ] ]
    else
      error_response = [ 404, { }, [ "Page Not Found\n" ] ]
    end

    if request.path == '/time'
      body = checked_formats.length > 0 ?
             error_response :
             [ "Format: #{formatted_date(formats_from_url, separator)}\n" ]
      [status, headers, body]
    else
      error_response
    end
  end

  def formatted_date(formats_from_url, separator)
    final_format = []
    formats_from_url.each do |value|
      final_format << Time.now.strftime(@@formats[value.to_sym])
    end
    final_format.join(separator)

  end

  def check_formats(formats_from_url)
    available_formats = []
    @@formats.each_key { |key| available_formats << key.to_s }

    (formats_from_url - available_formats)
  end
end
