class Player
  def initialize url
    err = Pointer.new(:object)
    @avPlayer = AVAudioPlayer.alloc.initWithContentsOfURL(url, error:err)
    puts err[0].localizedDescription if (!@avPlayer)
    err = Pointer.new(:object)
    @avPlayer.prepareToPlay
  end


  def play
    @avPlayer.play
  end

end
