require_relative 'Collisions'
require_relative 'point'
class Rect
  attr_accessor :x, :y, :w, :h, :a, :b, :c, :d
  def initialize(x, y, w, h)
    @x, @y, @w, @h = x, y, w, h
    @a = Point.new(x,y)
    @b = Point.new(@a.x + w, @a.y)
    @d = Point.new(@b.x, @b.y + h)
    @c = Point.new(@a.x, @a.y + h)
    @collision_box = Collisions::Collision_Box.new(@x, @y, @w, @h)
  end

  def collides_with?(other)
    @collision_box.collides?(other.Rect)
  end

  def to_s
    "A[#{@a}] b[#{@b}] c[#{@c}] d[#{@d}]"
  end

  def hash
    # [@x, @y, @w, @h].hash
    1
  end

  def ==(other)
    @x == other.x && 
    @y == other.y && 
    @w == other.w && 
    @h == other.h
  end

  def eql?(other)
    self == other
  end

end
