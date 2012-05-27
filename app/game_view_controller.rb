

class GameViewController < UIViewController
  def loadView
    self.view = GameView.alloc.init
  end

  def viewDidLoad
    super
    prepareRecorder

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
    @avPlayer = AVAudioPlayer.alloc.initWithContentsOfURL(url, error:err)
    @avPlayer.prepareToPlay
    @avPlayer.play
  end

  def prepareRecorder
    setCategory
    setActive
    @recorder = createRecorder
    @recorder.setDelegate(self)
    @recorder.prepareToRecord
  end


  def setCategory
    err = Pointer.new(:object)
    unless (audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error:err))
      NSLog("audioSession: %@ %d %@", err.domain, err.code, err.userInfo.description)  
    end
  end

  def setActive
    err = Pointer.new(:object)
    unless (audioSession.setActive(1, error:err))
      NSLog("audioSession: %@ %d %@", err.domain, err.code, err.userInfo.description)
    end
  end

  def createRecorder
    err = Pointer.new(:object)
    recorder = AVAudioRecorder.alloc.initWithURL(url, settings:recordSetting, error:err)
    puts err[0].localizedDescription if (!recorder)
    recorder
  end

  def audioSession
    @audioSession ||= AVAudioSession.sharedInstance
  end

  def dir
    NSHomeDirectory().stringByAppendingPathComponent("Documents")
  end

  def recorderFilePath
    #now = Time.now
    #caldate = now.description
    "#{dir}/MySound.caf"
  end

  def url
    NSURL.fileURLWithPath(recorderFilePath)
  end

  def recordSetting
    rs = NSMutableDictionary.alloc.init

    rs.setValue(NSNumber.numberWithInt(1768775988), forKey:AVFormatIDKey)
    rs.setValue(NSNumber.numberWithFloat(44100.0), forKey:AVSampleRateKey)
    rs.setValue(NSNumber.numberWithInt(1), forKey:AVNumberOfChannelsKey)
    rs
  end


end
