=begin
Write your code for the 'Hamming' exercise in this file. Make the tests in
`hamming_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/hamming` directory.
=end
module Hamming
  def self.compute(one, two)
    if one.length != two.length then raise ArgumentError.new end

    index = 0
    hamming = 0

    while index < one.length do
      if one[index] != two[index] then hamming += 1 end
      index += 1
    end

    return hamming
  end
end