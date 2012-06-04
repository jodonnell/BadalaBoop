class UI
  attr_accessor :width
  def initialize width
    @width = width
  end

  def createTextField delegate
    textField = UITextField.alloc.init
    textField.returnKeyType = UIReturnKeyDone
    textField.placeholder = "Email address"
    textField.textColor = UIColor.whiteColor
    textField.frame = getFrame 100
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords
    textField.adjustsFontSizeToFitWidth = true
    textField.addTarget(delegate, action:'doNothing', forControlEvents:UIControlEventEditingDidEndOnExit)
    textField
  end


  def createButton yPos, action, normalTitle, delegate
    button = getButton
    button.setTitle(normalTitle, forState:UIControlStateNormal)
    button.setTitle('Stop', forState:UIControlStateSelected)
    button.addTarget(delegate, action:action, forControlEvents:UIControlEventTouchUpInside)
    button.frame = getFrame yPos
    button
  end

  def boom
    20
  end

  private

  def getButton
    UIButton.buttonWithType(UIButtonTypeRoundedRect)
  end

  def getFrame yPos
    margin = 20
    [[margin, yPos], [@width - margin * 2, 40]]
  end
end
