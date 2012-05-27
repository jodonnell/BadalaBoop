describe FileUrl do
  it "has one window" do
    FileUrl.dir.should =~ /\/Applications\//
    FileUrl.dir.should =~ /\/Documents$/
  end

  it "returns the correct sound path" do
    FileUrl.recorderFilePath.should =~ /\/Documents\/MySound.caf$/
  end

  it "returns the correct url" do
    FileUrl.url.absoluteString.should =~ /Documents\/MySound.caf$/
  end
end


