describe Player do
  before do
    @url = FileUrl.new.url
    # recording = UIApplication.sharedApplication.delegate.window.rootViewController.recorder.newRecorder(@url)
    # recording.record
    # recording.stop
  end

  it "can create a AVAudioPlayer" do
    # player = Player.new(AVAudioPlayer, [@url])
    # player.avPlayers.should.not == nil
  end

  it "will play each avPlayer" do
    # tvm = OCMockObject.mockForClass(UITableView)
    # tvm.expect.andReturn(nil).dequeueReusableCellWithIdentifier("HelloWorldCell")
    # #tvm.dequeueReusableCellWithIdentifier("HelloWorldCell")
    # tvm.verify

    # 1.should == 1 #
    #mock.stub.andReturnValue(true).play()
    # mock = OCMockObject.mockForClass(AVAudioPlayer)
    # mock.expect.play()
    # mock.play()
    # mock.verify
    # player = Player.new(mock, [@url, @url])
    # player.play.should == [true, true]
  end

end


