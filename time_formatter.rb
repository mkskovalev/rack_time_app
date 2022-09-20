class TimeFormatter

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
    unknown_formats.length == 0
  end

  def formatted_time
    final_format = []
    @url_formats.each do |value|
      final_format << Time.now.strftime(FORMATS[value.to_sym])
    end
    final_format.join(@separator)
  end

  def unknown_formats
    unknown = []
    @url_formats.each { |value| unknown << value }
    FORMATS.each_key { |key| unknown.delete(key.to_s) }
    return unknown
  end
end
