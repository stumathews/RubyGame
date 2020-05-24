require_relative 'utils'
require_relative 'animation'
require_relative 'collisions'
require_relative 'rect'

class Player
  STEP = 10
  include Utils  
  include Animation
  def initialize(animation, x, y, w, h)
    @rect = Rect.new(x, y, w, h)
    super animation, x, y
  end

  def update
    super
  end

  def draw
    super
  end

  def Rect 
    @rect
  end


  def move_up
    @y -= STEP
  end

  def move_down
    @y += STEP
  end

  def move_left
    @x -= STEP
  end

  def move_right
    @x += STEP
  end


end

