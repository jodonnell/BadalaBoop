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
  end

  def createButton yPos, action, normalTitle
    margin = 20
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle(normalTitle, forState:UIControlStateNormal)
    button.setTitle('Stop', forState:UIControlStateSelected)
    button.addTarget(self, action:action, forControlEvents:UIControlEventTouchUpInside)
    button.frame = [[margin, yPos], [view.frame.size.width - margin * 2, 40]]
    view.addSubview(button)
    button
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
end
