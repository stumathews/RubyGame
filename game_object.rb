class GameObject
  attr_accessor :x, :y, :w, :h

  def Rect
    @rect
  end

  def initialize
    @rect = Rect.new(@x, @y, @w, @h)
  end

end
