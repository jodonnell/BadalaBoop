class FileUrl
  def self.dir
    NSHomeDirectory().stringByAppendingPathComponent("Documents")
  end

  def self.recorderFilePath
    #now = Time.now
    #caldate = now.description
    "#{dir}/MySound.caf"
  end

  def self.url
    NSURL.fileURLWithPath(recorderFilePath)
  end

end
