module PlayerBuilding
  def create_player(type, room_width, room_height)
    case type
    when :avatar
    player_asset = Utils.media_path('captain-m-001-light.png')
    @player =  Player.new(Gosu::Image.load_tiles(self, player_asset, 48, 64, false), x=500, y=300, w=48,h=64, step=5)
    when :cube
    @player =  Cube.new(x=500, y=300, w=room_width/3,h=room_height/3, step=room_width/10)
    end
  end 
end
