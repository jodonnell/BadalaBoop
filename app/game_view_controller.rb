class GameViewController < UIViewController
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
    @recording = @recorder.newRecorder(@fileUrl.url)
  end

  def doNothing
  end

  def recordButtonTapped
    if @isRecording
      @recording.stop
      @recordings << @fileUrl.url
      newRecording
    else
      @recording.record
    end
    @recordButton.selected = !@recordButton.selected?
    @isRecording = !@isRecording

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
