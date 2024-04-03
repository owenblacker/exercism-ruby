class Matrix
  attr_reader :rows
  attr_reader :full_matrix
  
  def initialize(s)
    @rows = s.split("\n")
    @full_matrix = @rows.map { |r| r.split }

    debug @full_matrix.inspect
    debug @full_matrix
  end

  def row(i)
    @full_matrix[i -1].collect(&:to_i)
  end

  def column(i)
    output = []
    @full_matrix.each { |r| output.push r[i -1].to_i }
    return output
  end
end