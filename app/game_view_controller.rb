class GameViewController < UIViewController
  def loadView
    self.view = GameView.alloc.init
  end

  def viewDidLoad
    super
    @fileUrl = FileUrl.new
    @recorder = Recorder.new
    @recording = @recorder.newRecorder(@fileUrl.url)
    @isRecording = false

    @action = createButton(260, 'actionTapped', 'Start')
    @play = createButton(320, 'playTapped', 'Play')
    @upload = createButton(380, 'uploadTapped', 'Upload')
    @textField = createTextField


  end

  def createTextField
    textField = UITextField.alloc.init
    textField.returnKeyType = UIReturnKeyDone
    textField.placeholder = "Email address"
    textField.textColor = UIColor.whiteColor
    textField.frame = getFrame 200
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords
    textField.adjustsFontSizeToFitWidth = true
    textField.addTarget(self, action:'doNothing', forControlEvents:UIControlEventEditingDidEndOnExit)
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
   if @isRecording
     @recording.stop
     @isRecording = false
   else
     @recording.record
     @isRecording = true
   end
    @action.selected = !@action.selected?
  end

  def playTapped
    err = Pointer.new(:object)
    @avPlayer = AVAudioPlayer.alloc.initWithContentsOfURL(@fileUrl.url, error:err)
    @avPlayer.prepareToPlay
    @avPlayer.play
  end

  def uploadTapped
    #uploadToS3

    url = NSURL.URLWithString("http://boobadoo.herokuapp.com/sound_files")
    @request = ASIFormDataRequest.alloc.initWithURL(url)
    @request.setFile(@fileUrl.recorderFilePath, forKey:"file")
    @request.setPostValue(@textField.text, forKey:"email")
    @request.startSynchronous
  end

  def uploadToS3
    secretAccessKey = "Tkv7xiK5ofLxvoQLv+x20mmhKypBIJEVixZ8M6rO"
    accessKey = "AKIAJAIG2D6NSZ2TI7CA"
    credentials = AmazonCredentials.alloc.initWithAccessKey(accessKey, withSecretKey: secretAccessKey)

    # ASIS3Request.setSharedSecretAccessKey("AKIAJAIG2D6NSZ2TI7CA")
    # ASIS3Request.setSharedAccessKey("AKIAJAIG2D6NSZ2TI7CA")
 
    # request = ASIS3ObjectRequest.PUTRequestForFile(@fileUrl.recorderFilePath, withBucket:"badalaboop", key:"boom")
    # request.startSynchronous
    # if (request.error)
    #   NSLog("%@", request.error.localizedDescription)
    # end

  end

  def download
    request = ASIHTTPRequest.requestWithURL(url)
    request.setDownloadDestinationPath("/Users/ben/Desktop/my_file.txt")
    request.startSynchronous
  end

end
