class AssemblyLine
  CARS_PER_HOUR = 221
  
  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    if @speed >=1 and @speed <= 4
      @success_rate = 1
    elsif @speed <= 8
      @success_rate = 0.9
    elsif @speed == 9
      @success_rate = 0.8
    elsif @speed = 10
      @success_rate = 0.77
    else
      @success_rate = 0
    end

    @speed * CARS_PER_HOUR * @success_rate
  end

  def working_items_per_minute
    (production_rate_per_hour / 60).floor
  end
end
