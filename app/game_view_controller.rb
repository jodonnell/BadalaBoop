class GameViewController < UIViewController
  attr_accessor :recorder

  def loadView
    self.view = GameView.alloc.init
  end

  def viewDidLoad
    super
    @recordings = []

    @recorder = Recorder.new
    @isRecording = false
    newRecording

    ui = UI.new(view.frame.size.width)
    @recordButton = ui.createButton(200, 'recordButtonTapped', 'Record', self)
    @loopButton = ui.createButton(260, 'loopButtonTapped', 'Loop', self)
    @playButton = ui.createButton(320, 'playButtonTapped', 'Play', self)
    @upload = ui.createButton(380, 'uploadTapped', 'Upload', self)
    @textField = ui.createTextField(self)

    view.addSubview(@recordButton)
    view.addSubview(@loopButton)
    view.addSubview(@playButton)
    view.addSubview(@upload)
    view.addSubview(@textField)
  end

  def newRecording
    @fileUrl = FileUrl.new
    @recording = @recorder.newRecorder(@fileUrl.url, self)
  end

  def stopRecording
    @recordButton.selected = false
    @isRecording = false

    removeRecordingViews
    @recordings << @fileUrl.url
    newRecording
  end

  def removeRecordingViews
    removeCountDownView
    removeRecordView
  end

  def startRecording
    @isRecording = true
    @recordButton.selected = true
    addRecordInView

    @timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target:self, selector:'beginRecording', userInfo:nil, repeats:false)
  end

  def addRecordInView
    @recordInView = CountDownView.alloc.initWithFrameAndDuration(CGRectMake(20, 20, 150, 60), 3)
    @recordInView.backgroundColor = UIColor.blackColor
    view.addSubview(@recordInView)
  end

  def removeRecordInView
    @recordInView.removeFromSuperview if @recordInView
  end

  def beginRecording
    removeRecordInView
    addRecordView

    if @recordings.empty?
      @recording.record
    else
      player = Player.new @recordings
      @recording.recordForDuration player.duration
      addCountDownView player.duration
      NSTimer.scheduledTimerWithTimeInterval(player.duration, target:self, selector:'removeRecordingViews', userInfo:nil, repeats:false)    
    end
  end

  def audioRecorderDidFinishRecording(recorder, successfully:flag)
    stopRecording
  end


  def addCountDownView duration
    @countDownView = CountDownView.alloc.initWithFrameAndDuration(CGRectMake(20, 20, 150, 60), duration)
    @countDownView.backgroundColor = UIColor.blackColor
    view.addSubview(@countDownView)
  end

  def removeCountDownView
    @countDownView.removeFromSuperview if @countDownView
  end

  def recordButtonTapped
    if @isRecording
      @recording.stop
      stopRecording
    else
      startRecording
    end
  end

  def addRecordView
    @recordView = RecordView.alloc.initWithFrame(CGRectMake(200, 40, 110, 30))
    @recordView.backgroundColor = UIColor.blackColor
    view.addSubview(@recordView)
  end

  def removeRecordView
    @recordView.removeFromSuperview if @recordView
  end

  def playButtonTapped
    play
  end

  def play
    @player = Player.new @recordings
    @player.play
  end

  def loopButtonTapped
    return if @isRecording
    if @isLooping
      @player.stop
    else
      @player = Player.new @recordings, true
      @player.play
    end
    @loopButton.selected = !@loopButton.selected?
    @isLooping = !@isLooping
  end

  def uploadTapped
    url = NSURL.URLWithString("http://localhost:3000/sound_files")
    @request = ASIFormDataRequest.alloc.initWithURL(url)
    @request.setFile(@fileUrl.recorderFilePath, forKey:"sound_file[file]")
    @request.startSynchronous
  end

  def download
    request = ASIHTTPRequest.requestWithURL(url)
    request.setDownloadDestinationPath("/Users/ben/Desktop/my_file.txt")
    request.startSynchronous
  end

  def recordButton
    @recordButton
  end

  def playButton
    @playButton
  end
end
