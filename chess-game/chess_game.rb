module Chess
  RANKS = 1..8
  FILES = 'A'..'H'

  def self.valid_square?(rank, file)
    debug "Test for #{rank} in ranks #{RANKS.to_a}: #{RANKS.include?(rank.to_i)}"
    debug "Test for #{file} in files #{FILES.to_a}: #{FILES.include?(file)}"
    
    RANKS.include?(rank.to_i) and FILES.include?(file)
  end

  def self.nick_name(first_name, last_name)
    (first_name[0...2] + last_name[-2..-1]).upcase
  end

  def self.move_message(first_name, last_name, square)
    nickname = self.nick_name(first_name, last_name)
    rank = square[1]
    file = square[0]

    if self.valid_square?(rank, file)
      "#{nickname} moved to #{square}"
    else
      "#{nickname} attempted to move to #{square}, but that is not a valid square"
    end
  end
end
