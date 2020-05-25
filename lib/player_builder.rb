module PlayerBuilding
  def create_player(type, room_width, room_height, rows, cols, room_number)
    gap = 10
    room_x = @rooms[room_number].x + gap
    room_y = @rooms[room_number].y + gap
    case type
    when :avatar
    gap = 10
    player_asset = Utils.media_path('captain-m-001-light.png')
    Player.new(Gosu::Image.load_tiles(self, player_asset, 48, 64, false),
               x=room_x, y=room_y, w=48,h=64, step=5)
    when :cube
    Cube.new(x=room_x, y=room_y,
             w=room_width/3,h=room_height/3, step=room_width/10)
    when :exit
    Cube.new(x=room_x, y=room_y,
             w=room_width/3,h=room_height/3, step=room_width/10, Gosu::Color::RED)
    end
  end 
end
