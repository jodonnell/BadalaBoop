describe Recorder do

  it "can create a AVAudioRecoder" do
    # Recorder.newRecorder(FileUrl.url).should.not == nil  This seems to freeze
  end

  it "sets the recordSettings correctly" do
    Recorder.recordSettings.has_key?(AVFormatIDKey).should == true
  end

end


