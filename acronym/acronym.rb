=begin
Write your code for the 'Acronym' exercise in this file. Make the tests in
`acronym_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/acronym` directory.
=end
class Acronym
  def self.abbreviate (term)
    words = term.split(/\W+/)
    output = ""
    words.each do |word|
      debug char = word.chars[0]&.upcase
      output += char
    end
    output
  end
end