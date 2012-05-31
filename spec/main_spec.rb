describe "Application 'BooBadoo'" do
  before do
    @app = UIApplication.sharedApplication
    @controller = @app.delegate.window.rootViewController
  end

  it "has one window" do
    @app.windows.size.should == 1
  end

end
