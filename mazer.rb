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
  @@points = 0
  @@level = 1
  
  # Initial game initialization and setup
  def initialize(width=800, height=600, options = { :fullscreen => false })
    super
    self.caption = 'Mazer Platformer in Ruby!'
    
    GameOptions::set_options(:show_solution => false)
    
    @background = Gosu::Image.new(BACKGROUND, {:tileable => false} )
    @success_sound = Gosu::Sample.new(Utils.media_path('complete.mp3'))
    @edge_sound = Gosu::Sample.new(Utils.media_path('buzzer.mp3'))
    @room_width = 50
    @room_height = 50
    
    set_cols_rows

    # -- Diagnostics -- 
    # @room_width = 100
    # @room_height = 100
    # @rows = 4
    # @cols = 4

    play_music
    create_level
  end

  def set_cols_rows
    @rows = height/@room_height
    @cols = width/@room_width
  end

  def create_level 
    # We only want to generate solvable mazes
    solved = false
    until solved do
      create_rooms(@rows, @cols, @room_width, @room_height)

      player_start_room_n = @rooms.sample.number
      exit_room_n = @rooms.sample.number

      @player = create_player :cube, @room_width, @room_height, @rows, @cols, player_start_room_n
      @exit = create_player :exit, @room_width, @room_height, @rows, @cols, exit_room_n
      
      # Generate a maze (randomly links rooms together i.e removes walls to make those links)
      Algorithms::Prims.on(@rooms, @rooms.sample)

      # Solve it to make sure its solvable, otherwise do it it again
      solved = Algorithms::Maze.solve(@rooms, player_start_room_n, exit_room_n)
    end
  end

  # Updates the game every frame
  def update

    # Get input from the player
    move_player(:up) if button_down?(Gosu::KbUp)
    move_player(:down) if button_down?(Gosu::KbDown)
    move_player(:left) if button_down?(Gosu::KbLeft)
    move_player(:right) if button_down?(Gosu::KbRight)

    # Update player and NPCs

    @player.update
    @exit.update

    # Check for player/room collisions 
    # reduce points on collision with walls
    @rooms.each { |room|
      if room.collides_with_rect?(@player.Rect)
        @@points -= 1
      end
    }

    # Check for win condition
    # spawn a new level if you've found the exit point
    if @player.Rect.collides_with_rect?(@exit.Rect)
      generate_next_level
    end

  end

  def generate_next_level
      @@level += 1
      @@points += 1000
      @success_sound.play
      @room_width -= 1 
      @room_height -= 1
      set_cols_rows
      create_level
  end


  # Draws the game every frame
  def draw
    @background.draw(0,0,0)
    
    @rooms.each  { |room| room.draw }
    @player.draw
    @exit.draw

    @hud = Gosu::Image.from_text(self, stats, Gosu::default_font_name, 30) 
    @hud.draw(10, 10, 0)
  end

  # Input Control
  def button_down(id)

    # Cheat - press 'r' to skip to next level
    if id == Gosu::KbR
      generate_next_level
    end

    options = GameOptions::get_options

    # Show/hide maze solution
    if id == Gosu::KbS
      show_solution = options[:show_solution]
      options.merge!({ :show_solution =>!show_solution })
      GameOptions::set_options(options)
    end 
    close if id == Gosu::KbEscape
  end

  def move_player(direction)
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
    "fps:#{Gosu.fps} Level: #{@@level} Points: #{@@points}"
    # "Level: #{@@level} Points: #{@@points}"
  end

end

puts "Gosu version=#{Gosu::VERSION}"
puts "License=#{Gosu::LICENSES}"
game = Game.new

# Enters the main game loop
game.show
