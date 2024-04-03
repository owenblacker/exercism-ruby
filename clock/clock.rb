class Clock
  public
  def initialize(params = {})
    @hour_internal = @minute_internal = 0
    
    self.hour = params[:hour] ||= 0
    self.minute = params[:minute] ||= 0

    debug ">> Init: #{params} -> #{self.hour}:#{self.minute}"
  end

  def to_s
    "#{pad(self.hour)}:#{pad(self.minute)}"
  end

  def +(arg)
    return Clock.new({hour: self.hour + arg.hour, minute: self.minute + arg.minute})
  end

  def -(arg)
    return Clock.new({hour: self.hour - arg.hour, minute: self.minute - arg.minute})
  end

  def ==(arg)
    return ((arg.hour == self.hour) and (arg.minute == self.minute))
  end

  def hour
    #debug "hour getter called; hour_internal = #{@hour_internal}"
    return @hour_internal % 24
  end

  def hour= (hour)
    # debug "hour setter called; hour_internal was #{@hour_internal}, value = #{hour}"
    @hour_internal = hour

    while @hour_internal < 0
      debug "negative hour_internal being incremented: #{@hour_internal}"
      @hour_internal += 24
    end

    #debug "before hour modulo #{@hour_internal}"
    @hour_internal = @hour_internal % 24
  end

  def minute
    #debug "minute getter called; minute_internal = #{@minute_internal}"
    return @minute_internal
  end

  def minute= (minute)
    debug "minute setter called; minute_internal was #{@minute_internal}, value = #{minute}"
    @minute_internal = minute

    while @minute_internal >= 60
      debug "Overvalued minutes being decremented: #{@hour_internal}:#{@minute_internal}"
      self.hour += 1
      @minute_internal -= 60
    end

    while @minute_internal < 0
      debug "Undervalued minutes being incremented: #{@hour_internal}:#{@minute_internal}"
      self.hour -= 1
      @minute_internal += 60
    end

    debug "Leaving minute setter: #{@hour_internal}:#{@minute_internal}"
  end
  
  private
  attr_reader :hour_internal
  attr_reader :minute_internal

  def pad(i)
    debug i
    if i == 0
      "00"
    elsif i < 10
      "0#{i}"
    else
      "#{i}"
    end
  end
end