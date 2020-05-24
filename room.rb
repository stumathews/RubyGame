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

  attr_accessor :neighbours, :x, :y, :w, :h, :number, :links, :col, :row
  
  def initialize(x, y, w, h)
    @x, @y, @w, @h = x, y, w, h
    @rect = Rect.new(@x, @y, @w, @h) #Overall Dimensions of the room
    @sides = {:top => true, :right => true, :left => true, :right_rectangle => true } # A room has all its sides initially 
    # We keep a rectangle per side for collision detection
    @top_rectangle = Rect.new(@rect.a.x, @rect.a.y, @w, 1)
    @right_rectangle = Rect.new(@rect.b.x, @rect.b.y, 1, @h)
    @left_rectangle = Rect.new(@rect.a.x, @rect.a.y, 1, @h)
    @bottom_rectangle = Rect.new(@rect.c.x, @rect.c.y, @w, 1)
    @neighbours = {}
    @links = []
    @col, @row = 0
  end

  def link(neighbour)
    @links << neighbour
    puts "linking myself(#{self}) to room #{neighbour}"
  end


  def draw
    draw_rectangle(@top_rectangle, AB_COLOR)
    draw_rectangle(@right_rectangle, BD_COLOR)
    draw_rectangle(@left_rectangle, CA_COLOR)
    draw_rectangle(@bottom_rectangle, DC_COLOR)
    draw_diagnostics
  end

  def collides_with?(other)
    sides = { 
      :top => @top_rectangle, 
      :right => @right_rectangle, 
      :left => @left_rectangle,
      :bottom => @bottom_rectangle
    }
    sides.any? { |k,v| v.collides_with?(other) }
  end
  
  def update

  end

  def to_s
    "x=#{@x}, y=#{@y}"
  end
  
  def draw_diagnostics
    neighbour_string = 
      "top=#{@neighbours[:top]&.number}\n"\
      "left=#{@neighbours[:left]&.number}\n"\
      "this=#{@number}\n"\
      "right=#{@neighbours[:right]&.number}\n"\
      "bottom=#{@neighbours[:bottom]&.number}"
    neighbours = Gosu::Image.from_text(neighbour_string, 18, { :font => Gosu::default_font_name })
    neighbours.draw(@x+5, @y+5, 0)
  end

  def draw_rectangle(rectangle, colour)
    r = rectangle
    Gosu.draw_rect(r.x, r.y, r.w, r.h, colour)
  end

end
