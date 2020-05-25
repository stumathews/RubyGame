require './lib/player'
require './lib/utils'
require './lib/algorithms'
require './lib/room_builder'
require './lib/player_builder'
require './lib/audio_building'
require './lib/options'

class Game < Gosu::Window
  include RoomBuilding
  include PlayerBuilding
  include AudioBuilding
  extend Utils
  
  BACKGROUND = Utils.media_path('background.jpg') 
  # Initial game initialization and setup
  def initialize(width=800, height=600, options = { :fullscreen => false })
    super
    self.caption = 'Mazer Platformer in Ruby!'
    GameOptions::set_options(:show_solution => false)
    @background = Gosu::Image.new(BACKGROUND, {:tileable => false} )
    @room_width = 50
    @room_height = 50
    @rows = height/@room_height
    @cols = width/@room_width
    # @room_width = 100
    # @room_height = 100
    # @rows = 4
    # @cols = 4
    play_music
    create_level
  end

  def create_level
    solved = false
    until solved do
      create_rooms(@rows, @cols, @room_width, @room_height)
      player_start_room = @rooms.sample.number
      exit_room = @rooms.sample.number

      @player = create_player :cube, @room_width, @room_height, @rows, @cols, player_start_room
      @exit = create_player :exit, @room_width, @room_height, @rows, @cols, exit_room
      Algorithms::Prims.on(@rooms, @rooms.sample)
      solved = Algorithms::Maze.solve(@rooms, player_start_room, exit_room)
      puts "unsolvable" if !solved
    end
  end
  # Updates the game every frame
  def update
    move(:up) if button_down?(Gosu::KbUp)
    move(:down) if button_down?(Gosu::KbDown)
    move(:left) if button_down?(Gosu::KbLeft)
    move(:right) if button_down?(Gosu::KbRight)
    @player.update
    @exit.update

    # Check for collisions
    @rooms.each { |room|
      if room.collides_with_rect?(@player.Rect)
        # puts "Collision with room: #{room} and player #{@player}" 
      # else
        # puts "No collisions currently"
      end
    }
    # spawn a new level if you've found the exit point
    create_level if @player.Rect.collides_with_rect?(@exit.Rect)
  end

  # Draws the game every frame
  def draw
    @background.draw(0,0,0)
    @hud = Gosu::Image.from_text(self, stats, Gosu::default_font_name, 30) 
    @hud.draw(10, 10, 0)
    
    @rooms.each  { |room| room.draw }
    @player.draw
    @exit.draw
  end

  # Called before update() if button is pressed
  def button_down(id)
    if id == Gosu::KbR
      puts "Recreating maze..."
      create_level
    end

    options = GameOptions::get_options
    if id == Gosu::KbS
      show_solution = options[:show_solution]
      options.merge!({ :show_solution =>!show_solution })
      GameOptions::set_options(options)
    end 
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
