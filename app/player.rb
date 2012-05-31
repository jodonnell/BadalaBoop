class Player
  def initialize recordings, loop=false
    recordings = recordings

    err = Pointer.new(:object)
    @avPlayers = recordings.collect do |recording|
      avPlayer = AVAudioPlayer.alloc.initWithContentsOfURL(recording, error:err)
      avPlayer.numberOfLoops = -1 if loop
      avPlayer.prepareToPlay
      avPlayer
    end
  end

  def play
    @avPlayers.each { |avPlayer| avPlayer.play }
  end

  def stop
    @avPlayers.each { |avPlayer| avPlayer.stop }
  end

end
