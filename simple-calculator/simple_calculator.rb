class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  def self.calculate(first_operand, second_operand, operation)
    if (first_operand == nil or second_operand == nil or operation == nil)
      raise UnsupportedOperation.new("One or more arguments is nil")
    elsif (first_operand == nil or second_operand == nil or !first_operand.is_a?(Integer) or !second_operand.is_a?(Integer))
      raise ArgumentError.new("Operands are not both numbers")
    elsif !operation.is_a?(String)
      raise ArgumentError.new("Operation is not a string")
    elsif ALLOWED_OPERATIONS === operation
      raise UnsupportedOperation.new("Unrecognised operation #{operation}")
    end

    begin
      case
      when '+' === operation then result = first_operand + second_operand
      when '*' === operation then result = first_operand * second_operand
      when '/' === operation then result = first_operand / second_operand
      else raise UnsupportedOperation.new("Unrecognised operation #{operation}")
      end
    rescue ZeroDivisionError
      return "Division by zero is not allowed."
    end
    return "#{first_operand} #{operation} #{second_operand} = #{result}"
  end

  class UnsupportedOperation < StandardError
  end
end