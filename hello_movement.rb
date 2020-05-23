require 'gosu'

class GameWindow < Gosu::Window

  def initialize(width=320, height=240, fullscreen=false)
    super
    self.caption = 'Hello Movement'
    @x = @y = 10
    @num_draws = 0
    @buttons_down = 0
  end

  def update
    @x -= 1 if button_down?(Gosu::KbLeft)
    @x += 1 if button_down?(Gosu::KbRight)
    @y -= 1 if button_down?(Gosu::KbDown)
    @y += 1 if button_down?(Gosu::KbUp)
  end

  def draw
    @num_draws += 1
    @message = Gosu::Image.from_text( self, info, Gosu.default_font_name, 30)
    @message.draw(@x, @y, 0)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
    @buttons_down += 1
  end

  def button_up(id)
    @buttons_down += 1
  end

  def needs_redraw?
    @num_draws == 0 || @buttons_down > 0
  end

  private

  def info
    "[x=#{@x} y=#{@y} draws=#{@num_draws}]"
  end

end

window = GameWindow.new
window.show
