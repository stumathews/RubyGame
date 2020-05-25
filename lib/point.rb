class Point
  attr_accessor :x, :y
  def initialize(x, y)
    set(x, y)
  end

  def set(x, y)
    @x, @y = x, y
  end

  
  def to_s
    "#{@x},#{@y}"
  end

end
