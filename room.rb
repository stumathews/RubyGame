require 'Gosu'

class Point
  
  attr_accessor :x, :y
  def initialize(x, y)
    @x, @y = x, y
  end
  
  def to_s
    "#{@x},#{@y}"
  end

end


class Rect
  attr_accessor :x, :y, :w, :h, :a, :b, :c, :d
  def initialize(x, y, w, h)
    @x, @y, @w, @h = x, y, w, h
    @a = Point.new(x,y)
    @b = Point.new(@a.x + w, @a.y)
    @d = Point.new(@b.x, @b.y+h)
    @c = Point.new(@a.x, @a.y + h)
  end

  def to_s
    "A[#{@a}] b[#{@b}] c[#{@c}] d[#{@d}]"
  end


end


# Represents a Room with four sides
class Room
  
  # 
  #  A-----B
  #  |     |
  #  |     |
  #  |     |
  #  C-----D

  AB_COLOR = Gosu::Color::WHITE
  BD_COLOR = Gosu::Color::WHITE
  DC_COLOR = Gosu::Color::WHITE
  CA_COLOR = Gosu::Color::WHITE

  def initialize(x, y, w, h)
    @x, @y, @w, @h = x, y, w, h
    @rect = Rect.new(@x, @y, @w, @h)
  end

  def draw
    #Draw A-B(top)
    Gosu.draw_rect(@rect.a.x, @rect.a.y, @w, 1, AB_COLOR)
    
    #Draw B-D (right)
    Gosu.draw_rect(@rect.b.x, @rect.b.y, 1, @h, BD_COLOR)
    
    #Draw C-A (left)
    Gosu.draw_rect(@rect.a.x, @rect.a.y, 1, @h, CA_COLOR)
    
    #Draw D-C (bottom)
    Gosu.draw_rect(@rect.c.x, @rect.c.y, @w, 1, DC_COLOR)
  end

  def update

  end

  def to_s
    "x=#{@x}, y=#{@y}"
  end

end
