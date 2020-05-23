require 'Gosu'
require_relative 'room'

class Game < Gosu::Window
  # Initial game initialization and setup
  def initialize(width=800, height=600, options = {:fullscreen=>false})
    super
    self.caption = 'Mazer Platformer in Ruby!'
    # Create rooms
    @rooms = []
    room_width = 100
    room_height = 100
    rows = height/room_height
    cols = width/room_width
    for r in 0..rows-1
      for c in 0..cols-1
        start_x = c * room_width
        start_y = r * room_height
        room = Room.new(start_x, start_y, room_width, room_height) 
        puts "Adding room: #{room}"
        @rooms << room
      end
    end
    puts "There are #{@rooms.size} rooms"
  end

  # Updates the game every frame
  def update

  end

  # Draws the game every frame
  def draw
    @hud = Gosu::Image.from_text(self, stats, Gosu::default_font_name, 30) 
    @hud.draw(0, 0, 0)
    
    @rooms.each  { |room| room.draw }
  end

  # Called before update() if button is pressed
  def button_down(id)
    puts "#{id}=>#{button_id_to_char(id)}"
  end

  # Called before update() if button is released
  def button_up(id)

  end

  # Determines if its needed to draw an new frame
  def needs_redraw?
    true 
  end

  def stats
    "fps:#{Gosu.fps}"
  end


end
puts "Gosu version=#{Gosu::VERSION}"
puts "License=#{Gosu::LICENSES}"
game = Game.new

# Enters the main game loop
game.show
