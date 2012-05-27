describe Recorder do

  it "sets the recordSettings correctly" do
    Recorder.recordSettings.has_key?(AVFormatIDKey).should == true
  end

end


