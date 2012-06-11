class RecordView < UIView
  attr_accessor :isRecording

  def init
    @isRecording = false
    super.init
  end

  def drawRect(rect)
    return unless @isRecording
    UIColor.whiteColor.set
    "Recording...".drawAtPoint(CGPoint.new(0, 0), withFont:UIFont.systemFontOfSize(20))
  end
end
