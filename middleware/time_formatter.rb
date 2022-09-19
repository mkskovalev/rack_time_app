class TimeFormatter

  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    if status == 200
      separator = body[0]
      url_formats = body[1].split(separator)
      body = [ "Format: #{ formatted_time(separator, url_formats) }\n" ]
    end

    [status, headers, body]
  end

  def formatted_time(separator, url_formats)
    final_format = []
    url_formats.each do |value|
      final_format << Time.now.strftime(App::FORMATS[value.to_sym])
    end
    final_format.join(separator)
  end


end
