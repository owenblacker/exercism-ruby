class LogLineParser
  REGEX = {
    level: /(?<=\[)([[:upper:]]+)(?=\]:)/,
    message: /[\[\][:upper:]]+: (.+)/
  }
  private_constant :REGEX
  attr_reader :line
  
  def initialize(input_line)
    @line = input_line
  end

  def message
    # debug "`@line`: #{@line}, `:line`: #{:line}, `line`: #{line}"
    match = line.match REGEX[:message]
    return match.captures[0]&.strip
  end

  def log_level
    match = line.match REGEX[:level]
    return match.captures[0]&.strip&.downcase
  end

  def reformat
    "#{message} (#{log_level})"
  end
end
