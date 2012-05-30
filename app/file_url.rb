class FileUrl
  def initialize
    now = Time.now
    @time = now.description
  end

  def dir
    NSHomeDirectory().stringByAppendingPathComponent("Documents")
  end

  def recorderFilePath
    "#{dir}/#{@time}.caf"
  end

  def url
    NSURL.fileURLWithPath(recorderFilePath)
  end

end
