require 'Gosu'
require_relative 'room'
require_relative 'player'
require_relative 'utils'

class Game < Gosu::Window
  extend Utils
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
    # rows = 2
    # cols = 2
    for r in 0..rows - 1
      for c in 0..cols - 1
        start_x = c * room_width
        start_y = r * room_height
        room = Room.new(start_x, start_y, room_width, room_height) 
        puts "Adding room: #{room}"
        @rooms << room
      end
    end
    for i in 0..@rooms.size
      next_index = i + 1
      prev_index = i - 1
      break if next_index >= @rooms.size

      this_row = (i / cols).abs()
      last_col = (this_row +1 * cols) -1
      this_col = cols - (last_col - i)
      
      # neighbour's index
      room_above_index = i - cols
      room_below_index = i + cols
      room_left_index = prev_index
      room_right_index = next_index

      room = @rooms[i]
      room.set_room_number(i)
      # Set the neighbours
      room.neighbours[:top] = @rooms[room_above_index]
      room.neighbours[:bottom] = @rooms[room_below_index]
      room.neighbours[:left] = @rooms[room_left_index]
      room.neighbours[:right] = @rooms[room_right_index]
      
      # possibly remove sides
      can_remove_above = room_above_index > 0
      can_remove_below = room_below_index < @rooms.size
      can_remove_left = this_col -1 >= 1
      can_remove_right = this_col +1 <= cols
      
      # report for neighbours
      puts "   [#{room_above_index}]"
      puts "[#{room_left_index}][#{i}][#{room_right_index}]  row=#{this_row}"
      puts "   [#{room_below_index}]"
    end
    puts "There are #{@rooms.size} rooms"
    # Create Player
    player_asset = Utils.media_path('captain-m-001-light.png')
    @player =  Player.new(Gosu::Image.load_tiles(self, player_asset, 48, 64, false), x=500, y=300, w=48,h=64)
  end

  # Updates the game every frame
  def update
    @player.update
    @rooms.each { |room|
      # puts "Collision with room: #{room}" if room.collides_with?(@player)
    }
  end

  # Draws the game every frame
  def draw
    @hud = Gosu::Image.from_text(self, stats, Gosu::default_font_name, 30) 
    @hud.draw(0, 0, 0)
    
    @rooms.each  { |room| room.draw }
    @player.draw

  end

  # Called before update() if button is pressed
  def button_down(id)
    move(:up) if id == Gosu::KbUp
    move(:down) if id == Gosu::KbDown
    move(:left) if id == Gosu::KbLeft
    move(:right) if id == Gosu::KbRight
    close if id == Gosu::KbEscape
  end

  def move(direction)
    case direction
    when :up
      @player.move_up
    when :down
      @player.move_down
    when :left
      @player.move_left
    when :right
      @player.move_right
    end

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
