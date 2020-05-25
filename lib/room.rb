require 'Gosu'
require_relative 'rect'
require_relative 'point'
require_relative 'options'

# Represents a Room with four sides
class Room
  
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
    # We keep a rectangle per side for collision detection
    @top_rectangle = Rect.new(@rect.a.x, @rect.a.y, @w, 1)
    @right_rectangle = Rect.new(@rect.b.x, @rect.b.y, 1, @h)
    @left_rectangle = Rect.new(@rect.a.x, @rect.a.y, 1, @h)
    @bottom_rectangle = Rect.new(@rect.c.x, @rect.c.y, @w, 1)
    @neighbours = {}
    @links = {}
  end

  def link_with(side)
    if @neighbours[side]
      @links[side] = @neighbours[side]
    end
  end

  def visit
    @mark = true
  end


  def draw
    draw_rectangle(Rect.new(@x+10, @y+10, @w/2,@h/2), Gosu::Color::BLUE) if @mark && GameOptions::get_options[:show_solution]
    draw_rectangle(@top_rectangle, AB_COLOR) unless @links[:top]
    draw_rectangle(@right_rectangle, BD_COLOR) unless @links[:right]
    draw_rectangle(@left_rectangle, CA_COLOR) unless @links[:left]
    draw_rectangle(@bottom_rectangle, DC_COLOR) unless @links[:bottom]
    # draw_diagnostics
  end

  def collides_with_rect?(other_rect)
    sides = { 
      :top => @top_rectangle, 
      :right => @right_rectangle, 
      :left => @left_rectangle,
      :bottom => @bottom_rectangle
    }


    # Only check for collisions with sides that are not linked to neighbours
    !@links[:top]    && sides[:top].collides_with_rect?(other_rect)    ||
    !@links[:bottom] && sides[:bottom].collides_with_rect?(other_rect) ||
    !@links[:right]  && sides[:right].collides_with_rect?(other_rect)  ||
    !@links[:left]   && sides[:left].collides_with_rect?(other_rect)
    # other_rect.collides_with_rect?(@rect)
      
  end
  
  def update

  end

  def to_s
    "x=#{@x}, y=#{@y} ##{@number}"
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
