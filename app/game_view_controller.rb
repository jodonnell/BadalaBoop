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

    @recordView = RecordView.alloc.initWithFrame(CGRectMake(200, 40, 110, 30))
    @recordView.backgroundColor = UIColor.blackColor
    view.addSubview(@recordView)

  end

  def newRecording
    @fileUrl = FileUrl.new
    @recording = @recorder.newRecorder(@fileUrl.url)
  end

  def stopRecording
    hideRecordView
    @recording.stop
    @recordings << @fileUrl.url
    newRecording
  end

  def startRecording
    view.startTime = Time.now
    view.setTimer

    @timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target:self, selector:'beginRecording', userInfo:nil, repeats:false)
  end

  def beginRecording
    showRecordView
    if @recordings.empty?
      @recording.record
    else
      @player = Player.new @recordings
      @recording.recordForDuration(@player.duration)
    end
  end

  def recordButtonTapped
    if @isRecording
      stopRecording
    else
      startRecording
    end

    @recordButton.selected = !@recordButton.selected?
    @isRecording = !@isRecording
  end

  def showRecordView
    @recordView.isRecording = true
    @recordView.setNeedsDisplay
  end

  def hideRecordView
    @recordView.isRecording = false
    @recordView.setNeedsDisplay
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
