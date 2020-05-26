require 'Gosu'
require_relative 'rect'
require_relative 'point'
require_relative 'options'

# Represents a Room with four independent sides
# Each side is represented by a Rect which thus can check itself for collision against another rect
class Room
  
  #  A-----B
  #  |     |
  #  |     |
  #  |     |
  #  C-----D

  AB_COLOR = Gosu::Color::BLACK
  BD_COLOR = Gosu::Color::BLACK
  DC_COLOR = Gosu::Color::BLACK
  CA_COLOR = Gosu::Color::BLACK
  LINE_WIDTH = 3

  attr_accessor :neighbours, :x, :y, :w, :h, :number, :links, :col, :row


  # A room represents a cell in the maze
  def initialize(x, y, w, h)
    @x, @y, @w, @h = x, y, w, h
    @rect = Rect.new(@x, @y, @w, @h) #Overall Dimensions of the room

    # We keep a rectangle per side/wall for collision detection
    @top_rectangle = Rect.new(@rect.a.x, @rect.a.y, @w, LINE_WIDTH)
    @right_rectangle = Rect.new(@rect.b.x, @rect.b.y, LINE_WIDTH, @h)
    @left_rectangle = Rect.new(@rect.a.x, @rect.a.y, LINE_WIDTH, @h)
    @bottom_rectangle = Rect.new(@rect.c.x, @rect.c.y, @w, LINE_WIDTH)
    @neighbours = {}
    @links = {}
  end

  def draw

    # Draw each side of the room unless it has been linked to a neighbour on that side
    draw_rectangle(@top_rectangle, AB_COLOR) unless @links[:top]
    draw_rectangle(@right_rectangle, BD_COLOR) unless @links[:right]
    draw_rectangle(@left_rectangle, CA_COLOR) unless @links[:left]
    draw_rectangle(@bottom_rectangle, DC_COLOR) unless @links[:bottom]
    
    # Draw the solution if this room was part of the solving process for the level
    if @mark && GameOptions::get_options[:show_solution]
      draw_rectangle(Rect.new(@x+10, @y+10, @w/2,@h/2), Gosu::Color::BLUE) 
    end
    # draw_diagnostics
  end
  
  # Use Gosu to draw a rectangle
  def draw_rectangle(rectangle, colour)
    r = rectangle
    Gosu.draw_rect(r.x, r.y, r.w, r.h, colour)
  end

  def collides_with_rect?(other_rect)

    # Relate sides with their associated rectangles (which can be used for collision detection)
    sides = 
    { 
      :top => @top_rectangle, 
      :right => @right_rectangle, 
      :left => @left_rectangle,
      :bottom => @bottom_rectangle
    }

    # Only check for collisions with sides that are not linked to neighbours
    # Smarten this up - map()
    !@links[:top]    && sides[:top].collides_with_rect?(other_rect)    ||
    !@links[:bottom] && sides[:bottom].collides_with_rect?(other_rect) ||
    !@links[:right]  && sides[:right].collides_with_rect?(other_rect)  ||
    !@links[:left]   && sides[:left].collides_with_rect?(other_rect)
  end
  
  # Associate a side with a neighbour - i.e open a passage to it i.e link it
  def link_with(side)
    if @neighbours[side]
      @links[side] = @neighbours[side]
    end
  end

  # Internal: used by the solving algorithm
  def visit
    @mark = true
  end
  
  # If we want to add some AI to rooms in the future
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
end
