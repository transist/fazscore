class FAZScore

  attr_accessor :decay, :population, :sqr_avg, :avg

  def initialize(decay, population)
    @sqr_avg = @avg = 0
    @decay = decay
    population.each { |p| self.update(p) }
  end

  def update(value)
    value = value.to_f
    if @avg == 0 and @sqr_avg == 0
      @avg = value
      @sqr_avg = value ** 2
    else
      @avg = @avg * @decay + value * (1 - @decay)
      @sqr_avg = @sqr_avg * @decay + (value ** 2) * (1 - @decay)
    end
  end

  def std
    Math.sqrt(@sqr_avg - @avg ** 2)
  end

  def score(obs)
    if std == 0
      offset = obs - @avg
      offset == 0 ? 0 : offset * Float::INFINITY
    else
      (obs - @avg) / std
    end
  end
end
