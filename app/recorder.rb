class Recorder
  def initialize
    setCategory
    enableMixing
    playThroughSpeaker
    setActive
  end

  def newRecorder url, delegate
    recorder = createRecorder(url)
    recorder.setDelegate(self)
    recorder.prepareToRecord
    recorder.delegate = delegate
    recorder
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

  def enableMixing
    propertySetError = 0
    allowMixing = Pointer.new(:bool)
    allowMixing[0] = true
    propertySetError = AudioSessionSetProperty(1668114808, 4, allowMixing) # KAudioSessionProperty_OverrideCategoryMixWithOthers
  end

  def playThroughSpeaker
    audioRouteOverride = Pointer.new(:uint)
    audioRouteOverride[0] = 1936747378 # kAudioSessionOverrideAudioRoute_Speaker
    AudioSessionSetProperty(1870033508, 4, audioRouteOverride) # kAudioSessionProperty_OverrideAudioRoute
  end

  def createRecorder url
    err = Pointer.new(:object)
    recorder = AVAudioRecorder.alloc.initWithURL(url, settings:recordSettings, error:err)
    puts err[0].localizedDescription if (!recorder)
    recorder
  end

  def audioSession
    @audioSession ||= AVAudioSession.sharedInstance
  end

  def recordSettings
    {AVFormatIDKey => 1768775988, AVSampleRateKey => 44100.0, AVNumberOfChannelsKey => 1} # kAudioFormatAppleIMA4
  end

end
