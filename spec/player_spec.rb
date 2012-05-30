describe Player do
  it "can create a AVAudioPlayer" do
    Player.new(FileUrl.new.url).should.not == nil
  end
end


