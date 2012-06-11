class CountDownView < UIView
  def initWithFrameAndDuration frame, duration
    view = initWithFrame frame
    @duration = duration
    @startTime = Time.now
    @recordingTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:'redraw', userInfo:nil, repeats:true)
    view
  end

  def redraw
    setNeedsDisplay
  end

  def drawRect(rect)
    timeLeft = @duration - (Time.now - @startTime)

    UIColor.whiteColor.set
    "Time left:".drawAtPoint(CGPoint.new(0, 20), withFont:UIFont.systemFontOfSize(16))
    ("%.1f" % timeLeft).drawAtPoint(CGPoint.new(90, 0), withFont:UIFont.systemFontOfSize(30))
  end
end
