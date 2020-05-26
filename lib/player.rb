require_relative 'utils'
require_relative 'animation'
require_relative 'rect'
require_relative 'player_internals'

# Stand-in for an animated character
class Cube
  include Utils  
  include PlayerInternals

  attr_accessor :x, :y, :w, :h

  def initialize(x, y, w, h, step, colour= Gosu::Color::WHITE)
    @rect = Rect.new(x, y, w, h)
    @x, @y, @w, @h = x, y, w, h
    @step = step
    @colour = colour
  end

  def draw
    Gosu.draw_rect(@x, @y, @w, @h, @colour)
  end

  def update
    update_rect
  end

end

# Animated character
class AvatarPlayer
  include Utils  
  include PlayerInternals
  include Animation

  def initialize( animation, x, y, z, w, h, step )
    super animation, x, y
    @rect = Rect.new(x, y, w, h)
    @step = step
  end

  def draw
    super
  end

  def update
    super
    update_rect
  end
end

class Player
  include Utils  
  include Animation

  def initialize(animation, x, y, w, h, step)
    @rect = Rect.new(x, y, w, h)
    @step = step
    super animation, x, y
  end

  def update
    super
    update_rect
  end

  def draw
    super
  end

  def Rect 
    @rect
  end

  def move_up
    @y -= @step
  end

  def move_down
    @y += @step
  end

  def move_left
    @x -= @step
  end

  def move_right
    @x += @step
  end
end
