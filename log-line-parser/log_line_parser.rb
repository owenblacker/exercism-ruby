class LogLineParser
  LOG_LEVEL_PATTERN = /(?<=\[)([[:upper:]]+)(?=\]:)/
  MESSAGE_PATTERN = /[\[\][:upper:]]+: (.+)/
  
  def initialize(line)
    @line = line
  end
  def message
    log_line = @line
    match = MESSAGE_PATTERN.match(log_line)
    return match.captures[0]&.strip
  end
  def log_level
    log_line = @line
    match = LOG_LEVEL_PATTERN.match(log_line)
    return match.captures[0]&.strip&.downcase
  end
  def reformat
    "#{message} (#{log_level})"
  end
end
