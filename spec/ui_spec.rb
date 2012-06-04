describe UI do

  it "can create a textfield" do
    ui = UI.new(100)
    mock = OCMockObject.partialMockForObject(ui)
    mock.stub.andCall('mockedButton', onObject:self).getButton
    mock.createButton(20, 'boom', 'title', self)
    mock.verify
  end

  def mockedButton
    mock = OCMockObject.niceMockForClass(UIButton)
    mock.expect.setTitle("title", forState: UIControlStateNormal)
    mock
  end

end
