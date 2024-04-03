class Scrabble
  def initialize(word)
    @word = word
  end

  def score
    score = 0
    for letter in @word.split("")
      score += letter_score(letter)
    end
    return score
  end

  def letter_score(letter)
    case letter.downcase
      when /[aeioulnrst]/ then 1
      when /[dg]/ then 2
      when /[bcmp]/ then 3
      when /[fhvwy]/ then 4
      when /[k]/ then 5
      when /[jx]/ then 8
      when /[qz]/ then 10
      else raise ArgumentException.new
    end
  end
end