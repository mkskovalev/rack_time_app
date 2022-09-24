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
    @unknown_formats = []
    @formatted = []
  end

  def call
    @url_formats.each do |value|
      if FORMATS[value.to_sym].nil?
        @unknown_formats << value
      else
        @formatted << FORMATS[value.to_sym]
      end
    end
  end

  def success?
    @unknown_formats.empty?
  end

  def formatted_time
    final_format = @formatted.join(@separator)
    Time.now.strftime(final_format)
  end

  def unknown_formats
    @unknown_formats.join(', ')
  end
end
