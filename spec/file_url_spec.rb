describe FileUrl do
  before do
    @file_url = FileUrl.new
  end

  it "ends with the same file-url name path" do
    recorderFile = @file_url.recorderFilePath.componentsSeparatedByString("/")[-1]
    urlFile = @file_url.url.absoluteString.componentsSeparatedByString("/")[-1]
    recorderFile.stringByAddingPercentEscapesUsingEncoding(NSASCIIStringEncoding).should == urlFile
  end

  it "should have the correct dir" do
    @file_url.dir.should =~ /\/Applications\//
    @file_url.dir.should =~ /\/Documents$/
  end

  it "returns the correct sound path" do
    @file_url.recorderFilePath.should =~ /\/Documents\/.*\.caf$/
  end

  it "returns the correct url" do
    @file_url.url.absoluteString.should =~ /Documents\/.*\.caf$/
  end
end


