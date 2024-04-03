module TwelveDays
  def self.song
    output = []

    (1..12).each { |day| output.push line(day) }

    return output.join("\n")
  end

  private
  @suppress_debugging = true

  def self.line (day)
    if day == 11 then @suppress_debugging = false end
    debug "Calling line for day #{day}" unless @suppress_debugging
    #debug "Calling line for day #{day}: #{@numbers[day].inspect}"
    
    "On the #{@numbers[day][:ordinal]} day of Christmas my true love gave to me: #{gifts(day)}.\n"
  end

  def self.gifts (day)
    debug "... Calling gifts for day #{day}" unless @suppress_debugging
    
    gift_list = "#{@numbers[day][:cardinal]} #{@numbers[day][:gift]}"

    if (day > 1) then
      gift_list += ", "
      
      if (day == 2) then gift_list += "and " end
      
      gift_list += gifts(day -1)
    end

    return gift_list
  end

  @numbers = [
    nil,
    { cardinal: "a",      ordinal: "first",    gift: "Partridge in a Pear Tree" },
    { cardinal: "two",    ordinal: "second",   gift: "Turtle Doves" },
    { cardinal: "three",  ordinal: "third",    gift: "French Hens"},
    { cardinal: "four",   ordinal: "fourth",   gift: "Calling Birds"},
    { cardinal: "five",   ordinal: "fifth",    gift: "Gold Rings"},
    { cardinal: "six",    ordinal: "sixth",    gift: "Geese-a-Laying"},
    { cardinal: "seven",  ordinal: "seventh",  gift: "Swans-a-Swimming"},
    { cardinal: "eight",  ordinal: "eighth",   gift: "Maids-a-Milking"},
    { cardinal: "nine",   ordinal: "ninth",    gift: "Ladies Dancing"},
    { cardinal: "ten",    ordinal: "tenth",    gift: "Lords-a-Leaping"},
    { cardinal: "eleven", ordinal: "eleventh", gift: "Pipers Piping"},
    { cardinal: "twelve", ordinal: "twelfth",  gift: "Drummers Drumming"}
  ]
end