module PlayerInternals

  def update_rect
    @rect.set_points(@x, @y, @w, @h)    
  end

  
  def Rect 
    @rect
  end

  def move_up
    @y -= @step
  end

  def move_down
    @y += @step
  end

  def move_left
    @x -= @step
  end

  def move_right
    @x += @step
  end

  def to_s
    "x:#{@x}, y:#{@y}"
  end

end

