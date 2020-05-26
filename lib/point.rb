class Point
  attr_accessor :x, :y
  def initialize(x, y)
    set(x, y)
  end

  # This allows us to update/reset an existing point without having to reconstruct it
  def set(x, y)
    @x, @y = x, y
  end
  
  def to_s
    "#{@x},#{@y}"
  end

end
