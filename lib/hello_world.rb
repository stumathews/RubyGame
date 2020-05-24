require 'gosu'

class GameWindow < Gosu::Window
  def initialize(width=320, height=240, fullscreen=false)
    super
    self.caption = 'Hello'
    @message = Gosu::Image.from_text(self, 'Hello World!', Gosu.default_font_name, 30)
  end

  # override: called on every frame
  def draw
    @message.draw(x=10,y=10,z=0)
  end
end

window = GameWindow.new
window.show
