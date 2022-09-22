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
    @unknown = unknown_formats
  end

  def success?
    @unknown.length == 0
  end

  def formatted_time
    final_format = convert_url_formats('formatted').join(@separator)
    Time.now.strftime(final_format)
  end

  private

  def unknown_formats
    unknown = convert_url_formats('unknown')
    FORMATS.each_key { |key| unknown.delete(key.to_s) }
    return unknown
  end

  def convert_url_formats(method)
    @url_formats.map { |value| method == 'formatted' ? FORMATS[value.to_sym] : value }
  end
end
