class GameViewController < UIViewController
  def loadView
    self.view = GameView.alloc.init
  end

  def viewDidLoad
    super
    @recorder = Recorder.newRecorder(FileUrl.url)
    @recording = false

    @action = createButton(260, 'actionTapped', 'Start')
    @play = createButton(320, 'playTapped', 'Play')
    @upload = createButton(380, 'uploadTapped', 'Upload')
    @textField = createTextField


  end

  def createTextField
    textField = UITextField.alloc.init
    textField.returnKeyType = UIReturnKeyDone;
    textField.placeholder = "Email address";
    textField.textColor = UIColor.whiteColor
    textField.frame = getFrame 200
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    textField.adjustsFontSizeToFitWidth = TRUE;
    textField.addTarget(self,  action:'doNothing',  forControlEvents:UIControlEventEditingDidEndOnExit)
    view.addSubview(textField)
    textField
  end


  def doNothing
  end

  def createButton yPos, action, normalTitle
    margin = 20
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle(normalTitle, forState:UIControlStateNormal)
    button.setTitle('Stop', forState:UIControlStateSelected)
    button.addTarget(self, action:action, forControlEvents:UIControlEventTouchUpInside)
    button.frame = getFrame yPos
    view.addSubview(button)
    button
  end

  def getFrame yPos
    margin = 20
    [[margin, yPos], [view.frame.size.width - margin * 2, 40]]
  end

  def actionTapped
   if @recording
     @recorder.stop
     @recording = false
   else
     @recorder.record
     @recording = true
   end
    @action.selected = !@action.selected?
  end

  def playTapped
    err = Pointer.new(:object)
    @avPlayer = AVAudioPlayer.alloc.initWithContentsOfURL(FileUrl.url, error:err)
    @avPlayer.prepareToPlay
    @avPlayer.play
  end

  def uploadTapped
    url = NSURL.URLWithString("http://boobadoo.herokuapp.com/sound_files")
    @request = ASIFormDataRequest.alloc.initWithURL(url)
    @request.setFile(FileUrl.recorderFilePath, forKey:"file")
    @request.setPostValue(@textField.text, forKey:"email")
    @request.startSynchronous
  end

  def download
    request = ASIHTTPRequest.requestWithURL(url)
    request.setDownloadDestinationPath("/Users/ben/Desktop/my_file.txt")
    request.startSynchronous
  end

end
