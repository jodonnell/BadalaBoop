class Recorder
  def self.newRecorder url
    setCategory
    setActive
    recorder = createRecorder(url)
    recorder.setDelegate(self)
    recorder.prepareToRecord
    recorder
  end

  def self.setCategory
    err = Pointer.new(:object)
    unless (audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error:err))
      NSLog("audioSession: %@ %d %@", err.domain, err.code, err.userInfo.description)  
    end
  end

  def self.setActive
    enableMixing
    playThroughSpeaker

    err = Pointer.new(:object)
    unless (audioSession.setActive(1, error:err))
      NSLog("audioSession: %@ %d %@", err.domain, err.code, err.userInfo.description)
    end
  end

  def enableMixing
    propertySetError = 0
    allowMixing = Pointer.new(:bool)
    allowMixing[0] = true
    propertySetError = AudioSessionSetProperty(1668114808, 4, allowMixing);
  end

  def playThroughSpeaker
    audioRouteOverride = Pointer.new(:uint)
    audioRouteOverride[0] = 1936747378
    AudioSessionSetProperty(1870033508, 4, audioRouteOverride) # kAudioSessionProperty_OverrideAudioRoute
  end

  def self.createRecorder url
    err = Pointer.new(:object)
    recorder = AVAudioRecorder.alloc.initWithURL(url, settings:recordSettings, error:err)
    puts err[0].localizedDescription if (!recorder)
    recorder
  end

  def self.audioSession
    @audioSession ||= AVAudioSession.sharedInstance
  end

  def self.recordSettings
    {AVFormatIDKey => 1768775988, AVSampleRateKey => 44100.0, AVNumberOfChannelsKey => 1} # KAudioFormatAppleIMA4
  end

end
