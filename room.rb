require 'Gosu'
require_relative 'rect'
require_relative 'point'
require_relative 'game_object'

# Represents a Room with four sides
class Room < GameObject
  
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
    @rect = Rect.new(@x, @y, @w, @h) #Overall Dimensions of the room
    
    # We keep a rect per side for collision detection
    @top_rect = Rect.new(@rect.a.x, @rect.a.y, @w, 1)
    @right_rect = Rect.new(@rect.b.x, @rect.b.y, 1, @h)
    @left_rect = Rect.new(@rect.a.x, @rect.a.y, 1, @h)
    @bottom_rect = Rect.new(@rect.c.x, @rect.c.y, @w, 1)
  end

  def draw
    draw_rect(@top_rect, AB_COLOR)
    draw_rect(@right_rect, BD_COLOR)
    draw_rect(@left_rect, CA_COLOR)
    draw_rect(@bottom_rect, DC_COLOR)
  end

  def draw_rect(rect, colour)
    r = rect
    Gosu.draw_rect(r.x, r.y, r.w, r.h, colour)
  end

  def collides_with?(other)
    sides = { 
      :top => @top_rect, 
      :right => @right_rect, 
      :left => @left_rect,
      :bottom => @bottom_rect
    }
    sides.any? { |k,v| v.collides_with?(other) }
  end


  def update

  end

  def to_s
    "x=#{@x}, y=#{@y}"
  end

end
