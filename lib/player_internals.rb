module PlayerInternals
  def update
  end

  def draw
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
end

