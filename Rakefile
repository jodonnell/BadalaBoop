$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'motion-cocoapods'


Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'BadalaBoop'
  app.provisioning_profile = '/Users/jacobodonnell/Library/MobileDevice/Provisioning Profiles/7CD5AEC7-711F-4B7B-9A3A-018967765BC2.mobileprovision'
  app.frameworks << 'CoreAudio'
  app.frameworks << 'AVFoundation'

  app.pods do
    dependency 'ASIHTTPRequest'
    dependency 'AWSiOSSDK'
  end
end
