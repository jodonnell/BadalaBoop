describe UI do

  it "can create a button" do
    ui = UI.new(100)
    mock = OCMockObject.partialMockForObject(ui)
    mock.stub.andCall('mockedButton', onObject:self).getButton

    mock.createButton(20, 'boom', 'title', self)
    mock.verify
    1.should == 1
  end

  def mockedButton
    mock = OCMockObject.niceMockForClass(UIButton)
    mock.expect.setTitle("title2", forState: UIControlStateNormal)
    mock
  end

end
