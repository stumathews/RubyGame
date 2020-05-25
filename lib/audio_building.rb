require_relative 'utils'
module AudioBuilding

 def play_music
   @music = Gosu::Song.new(self, Utils.media_path('menu_music.mp3'))
    @music.volume = 0.5
    @music.play(true)
 end 

end

