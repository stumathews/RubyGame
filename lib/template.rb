require 'Gosu'

class Game < Gosu::Window
  
  # Initial game initialization and setup
  def initialize(width=800, height=600, options = {:fullscreen=>false})
    super
    self.caption = 'Mazer Platformer in Ruby!'
  end

  # Updates the game every frame
  def update

  end

  # Draws the game every frame
  def draw
    @hud = Gosu::Image.from_text(self, stats, Gosu::default_font_name, 30) 
    @hud.draw(0, 0, 0)

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

