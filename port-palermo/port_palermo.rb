module Port
  IDENTIFIER = :PALE

  def self.get_identifier(city)
    city.slice(0,4).upcase.to_sym
  end

  def self.get_terminal(ship_identifier)
    cargo = ship_identifier.to_s.slice(0,3)
    if cargo == "OIL" or cargo == "GAS"
      "A".to_sym
    else
      "B".to_sym
    end
  end
end
