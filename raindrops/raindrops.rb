module Raindrops
  def self.convert(input)
    output = ""
    debug input

    if input % 3 == 0 then output += "Pling" end
    if input % 5 == 0 then output += "Plang" end
    if input % 7 == 0 then output += "Plong" end

    debug output
    if output == "" then output = input.to_s end

    return output
  end
end