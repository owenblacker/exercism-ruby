=begin
Write your code for the 'Resistor Color Duo' exercise in this file. Make the tests in
`resistor_color_duo_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/resistor-color-duo` directory.
=end
class ResistorColorDuo
  CE = COLOUR_ENCODING = [
    "black", "brown", "red", "orange", "yellow", "green",
    "blue", "violet", "grey", "white"
  ]
  
  def self.value(colours)
    colours[0..1].map { |e| CE.find_index(e) }.join.to_i
  end
end