module Animation
  FRAME_DELAY = 10

 def initialize(animation, x, y)
    @animation = animation
    @x, @y = x, y
    @current_frame = 0
  end

  def update
    @current_frame += 1 if frame_expired?
  end

  def draw # I can draw myself
    image = current_frame
    image.draw(@x - image.width / 2.0, @y - image.height / 2.0, 0)
  end

 private

  def current_frame
    @animation[@current_frame % @animation.size]
  end

  def frame_expired?
    now = Gosu.milliseconds
    @last_frame ||= now
    if(now - @last_frame) > FRAME_DELAY
      @last_frame = now
    end
  end

end

