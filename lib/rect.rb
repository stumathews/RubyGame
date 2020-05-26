require_relative 'point'
require_relative 'player' 

# The basis of collision detection in the game
# Also represents the dimensions of any rectangle using the below model A->B->D->C
class Rect

  #  A-----B
  #  |     |
  #  |     |
  #  |     |
  #  C-----D
  attr_accessor :x, :y, :w, :h, :a, :b, :c, :d

  def initialize(x, y, w, h)
    @x, @y, @w, @h = x, y, w, h
    set_points(@x, @y, @w, @h)
  end


  # Each point in the rectangle is represented by a Point class 
  def set_points(x, y, w,h)
    ax = x
    ay = y
    bx = ax + w
    by = ay
    dx = bx
    dy = by + h
    cx = ax
    cy = ay + h
   
    # Update or set the points for this rect - useful when updating for movement of points(moving characters) 
    if @a
      @a.set(ax,ay)
    else
      @a = Point.new(ax,ay)
    end

    if @b
      @b.set(bx,by)
    else
      @b = Point.new(bx,by)
    end
    if @d
      @d.set(dx,dy)
    else
      @d = Point.new(dx,dy)
    end
    if @c
      @c.set(cx,cy)
    else
      @c = Point.new(cx,cy)
    end
  end

  # Main collision detection routine - check if two rectangles intersect
  def collides_with_rect?(rect_b)
    ax1 = @a.x
    ax2 = @d.x
    ay1 = @a.y
    ay2 = @d.y
    
    b = rect_b

    bx1 = b.a.x
    bx2 = b.d.x
    by1 = b.a.y
    by2 = b.d.y

    collision =  ax1 < bx2 &&
      ax2 > bx1 &&
      ay1 < by2 && 
      ay2 > by1
    collision
  end

  def eql?(other)
    self == other
  end

end
