
Pod::Spec.new do |s|
  s.name             = "AppBasic"
  s.version          = "1.0.0"
  s.summary          = "App Basic"
  s.description      = <<-DESC
  Crash Exception Handler
                       DESC

  s.homepage         = "https://github.com/leocll/CLLExceptionHandler.git"
  s.license          = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.author           = { "leocll" => "leocll@qq.com" }
  s.source           = { :git => "https://github.com/leocll/AppBasics.git", :branch => 'master' }
  s.source_files     = "AppBasic/Basic/**/*"
  s.ios.deployment_target = "8.0"

end
