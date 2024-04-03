module Blackjack
  def self.parse_card(card)
    case card
    when "ace" then 11
    when "two" then 2
    when "three" then 3
    when "four" then 4
    when "five" then 5
    when "six" then 6
    when "seven" then 7
    when "eight" then 8
    when "nine" then 9
    when "ten", "jack", "queen", "king" then 10
    else 0
    end
  end

  def self.card_range(card1, card2)
    sum = parse_card(card1) + parse_card(card2)
    debug "#{card1} plus #{card2} equals #{sum}"
    
    case sum
    when 4..11 then "low"
    when 12..16 then "mid"
    when 17..20 then "high"
    when 21 then "blackjack"
    else "error"
    end
  end

  def self.first_turn(card1, card2, dealer_card)
    case
    when (card1 == "ace" and card2 == "ace") then "P"
    when card_range(card1, card2) == "blackjack"
      if beat_blackjack?(dealer_card) then "S"
      else "W"
      end
    when card_range(card1, card2) == "high" then "S"
    when card_range(card1, card2) == "mid"
      if parse_card(dealer_card) >= 7 then "H"
      else "S"
      end
    when card_range(card1, card2) == "low" then "H"
    else
      raise "unexpected combination"
    end
  end

  def self.beat_blackjack?(dealer_card)
    case dealer_card
    when "ace", "jack", "queen", "king", "ten"
      true
    else
      false
    end
  end
end
