module SavingsAccount
  THRESHOLD1 = 0
  THRESHOLD2 = 1000
  THRESHOLD3 = 5000
  INTEREST1 = 3.213
  INTEREST2 = 0.5
  INTEREST3 = 1.621
  INTEREST4 = 2.475
  
  def self.interest_rate(balance)
    if balance < THRESHOLD1
      INTEREST1
    elsif balance < THRESHOLD2
      INTEREST2
    elsif balance < THRESHOLD3
      INTEREST3
    else
      INTEREST4
    end
  end

  def self.annual_balance_update(balance)
    balance + (balance * self.interest_rate(balance) / 100)
  end

  def self.years_before_desired_balance(current_balance, desired_balance)
    counter = 0
    until current_balance >= desired_balance
      current_balance = self.annual_balance_update(current_balance)
      counter += 1
    end
    
    return counter
  end
end
