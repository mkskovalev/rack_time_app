class App

  FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }

  def call(env)
    @request = Rack::Request.new env
    @request_params = @request.params["format"]

    response
  end

  private

  def response

    if request_correct?
      @separator = @request_params[/\W|[_]/]
      @url_formats = @request_params.split(@separator)

      unknown_formats(@url_formats).length == 0 ? response_params(:success) : response_params(:has_unknown)
    else
      response_params(:failed)
    end
  end

  def request_correct?
    @request.path == '/time' && request_has_format_params?
  end

  def request_has_format_params?
    @request_params != nil
  end

  def unknown_formats(url_formats)
    FORMATS.each_key { |key| url_formats.delete(key.to_s) }
    url_formats
  end

  def response_params(status)
    case status
    when :success
      [ 200,
        { 'content-type' => 'text/plain' },
        [ @separator, @request_params ] ]

    when :has_unknown
      [ 400,
        { 'content-type' => 'text/plain' },
        [ "Unknown time format #{ unknown_formats(@url_formats) }\n" ] ]

    when :failed
      [ 404,
        {},
        [ "Page Not Found\n" ] ]

    end
  end
end
