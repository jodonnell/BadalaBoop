class RecordView < UIView
  def drawRect(rect)
    UIColor.whiteColor.set
    "Recording...".drawAtPoint(CGPoint.new(0, 0), withFont:UIFont.systemFontOfSize(20))
  end
end
