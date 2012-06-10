class GameView < UIView
  attr_accessor :startTime

  def setTimer
    @timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector:'redraw', userInfo:nil, repeats:1)
    @timer.fire
  end

  def redraw
    setNeedsDisplay
  end

  def drawRect(rect)
    return if @startTime.nil?
    clearBackground


    timeLeft = 3 - (Time.now - @startTime).to_i
    
    if timeLeft <= 0
      @timer.invalidate
      return
    end

    UIColor.whiteColor.set
    "Record in:".drawAtPoint(CGPoint.new(20, 40), withFont:UIFont.systemFontOfSize(20))
    timeLeft.to_s.drawAtPoint(CGPoint.new(140, 20), withFont:UIFont.systemFontOfSize(60))
  end

  def clearBackground
    bgcolor = UIColor.blackColor
    bgcolor.set
    UIBezierPath.bezierPathWithRect(frame).fill
  end

end
