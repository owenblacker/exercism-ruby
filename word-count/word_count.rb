=begin
Write your code for the 'Word Count' exercise in this file. Make the tests in
`word_count_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/word-count` directory.
=end
class Phrase
  attr_reader :phrase
  attr_reader :word_count
  
  def initialize(input_string)
    @phrase = input_string
    separators = /[^\w0-9']+/

    every_word = input_string.downcase.split(separators).map { |w| w.delete_prefix("'").delete_prefix('"').delete_suffix("'").delete_suffix('"') }.compact
    @word_count = every_word.uniq.map { |w| { w => every_word.count(w)} }.inject(:merge!).delete_if { |k,v| k == "" or v == 0 }

    debug @word_count
  end
end