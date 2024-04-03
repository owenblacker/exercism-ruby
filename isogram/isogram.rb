module Isogram
  def self.isogram?(input)
    re = /([a-z]).*\1/
    debug input + ": " + (!input.match?(re)).to_s
    return !input.downcase.match?(re)
  end
end