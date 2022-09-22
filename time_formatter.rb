class TimeFormatter
  attr_reader :unknown

  FORMATS = {
    year: '%Y',
    month: '%m',
    day: '%d',
    hour: '%H',
    minute: '%M',
    second: '%S'
  }

  def initialize(params)
    params = params
    @separator = params[/\W|[_]/]
    @url_formats = params.split(@separator)
  end

  def success?
    @converted_formats = @url_formats.map {
      |value| FORMATS[value.to_sym].nil? ? value : FORMATS[value.to_sym]
    }
    @unknown = unknown_formats
    @unknown.length == 0
  end

  def formatted_time
    final_format = @converted_formats.join(@separator)
    Time.now.strftime(final_format)
  end

  private

  def unknown_formats
    unknown = @converted_formats.map { |value| value }
    FORMATS.each_value { |value| unknown.delete(value.to_s) }
    return unknown
  end

  def convert_url_formats(method)

  end
end
