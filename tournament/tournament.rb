module Tournament
  def self.tally (input)
    @tournament = Hash.new
      
    input.split("\n").each { |line| parse_line(line)}
    display_output
  end

  private
  HEADER = "Team                           | MP |  W |  D |  L |  P"
  SEPARATOR = " | "
  DEFAULTS_VALUES = { played: 0, won: 0, drawn: 0, lost: 0, points: 0 }
  TEAM_DEFAULTS = Marshal.load(Marshal.dump(DEFAULTS_VALUES))
  # tournament["team"] = { played: 0, won: 0, drawn: 0, lost: 0, points: 0 }

  def self.parse_line (line)
    split_line = line.split(";")
    team1 = split_line[0]
    team2 = split_line[1]
    result = split_line[2]

    # debug "“#{line}” -> #{team1} v #{team2} was a #{result}"
    if !(@tournament.has_key?(team1)) then @tournament[team1] = TEAM_DEFAULTS.dup end
    if !(@tournament.has_key?(team2)) then @tournament[team2] = TEAM_DEFAULTS.dup end

    # debug "tournament['#{team1}'][:played] = #{@tournament[team1][:played]}"
      
    @tournament[team1][:played] += 1
    @tournament[team2][:played] += 1

    case result
      when "win"
        # debug "#{team1} won"
        @tournament[team1][:won] += 1
        @tournament[team1][:points] += 3
        @tournament[team2][:lost] += 1
      when "loss"
        # debug "#{team2} won"
        @tournament[team1][:lost] += 1
        @tournament[team2][:won] += 1
        @tournament[team2][:points] += 3
      when "draw"
        # debug "Draw"
        @tournament[team1][:drawn] += 1
        @tournament[team1][:points] += 1
        @tournament[team2][:drawn] += 1
        @tournament[team2][:points] += 1
    else
      throw ArgumentError.new("Line “#{line}” contained unrecognised result “#{result}”")
    end
  end

  def self.display_output
    #debug "Outputting results table #{@tournament.inspect}"
    output = [HEADER]

    @tournament.keys
    .sort_by { |team| [ -(@tournament[team][:points]), team ] }
    .each do |team|
        line = [
          pad_name(team),
          pad_number(@tournament[team][:played]),
          pad_number(@tournament[team][:won]),
          pad_number(@tournament[team][:drawn]),
          pad_number(@tournament[team][:lost]),
          pad_number(@tournament[team][:points])
        ]
        output.push(line.join(SEPARATOR))
      end

    debug output.join("\n")

    return output.join("\n") + "\n"
  end

  def self.pad_name (team_name)
    full_length = HEADER.split(SEPARATOR)[0].length
    return team_name.ljust(full_length)
  end

  def self.pad_number (num)
    return num.to_s.rjust(2)
  end
end