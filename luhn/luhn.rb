module Luhn
  def self.valid?(number)
    debug "[#{number}]"
    number = number.gsub(/ +/, "")
    debug "[#{number}]"
    if number.length <= 1 or /[^0-9]/ === number
      debug "Either too short or contains non-digits"
      return false
    end

    sum = 0

    number.split("").reverse.each_with_index do |char, index|
      digit = char.to_i

      if index % 2 == 1
        increment = digit * 2
        if increment > 9 then increment -= 9 end
        # Not modulo, because 9 -> 9, not 0
          
        sum += increment
        debug "#{digit} -> #{increment}; sum now #{sum}"
      else
        sum += digit
        debug "#{digit} unaltered; sum now #{sum}"
      end
    end

    debug "Testing #{sum} divisible by 10"
  
    return !!(sum % 10 == 0)
  end
end
