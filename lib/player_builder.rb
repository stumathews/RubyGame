module PlayerBuilding
  def create_player

    player_asset = Utils.media_path('captain-m-001-light.png')
    @player =  Player.new(Gosu::Image.load_tiles(self, player_asset, 48, 64, false), x=500, y=300, w=48,h=64)
  end 
end
