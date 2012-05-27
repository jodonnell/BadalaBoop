describe "Application 'Hello'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "has one window" do
    @app.windows.size.should == 1
  end

  it "returns the correct sound path" do
    @app.delegate.window.rootViewController.recorderFilePath.should =~ /\/Documents\/MySound.caf/
  end

  it "returns the correct url" do
    @app.delegate.window.rootViewController.url.absoluteString.should =~ /Documents\/MySound.caf/
  end

  it "sets the recordSettings correctly" do
    @app.delegate.window.rootViewController.recordSetting.has_key?(AVFormatIDKey).should == true
  end

end


