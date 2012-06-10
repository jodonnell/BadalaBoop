class RecordView < UIView
  attr_accessor :isRecording

  def init
    @isRecording = false
    init
  end

  def drawRect(rect)
    UIColor.whiteColor.set
    "Recording...".drawAtPoint(CGPoint.new(0, 0), withFont:UIFont.systemFontOfSize(20)) if @isRecording
  end
end
