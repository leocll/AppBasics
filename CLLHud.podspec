
Pod::Spec.new do |ss|
ss.name             = "CLLHud"
ss.version          = "1.0.0"
ss.summary          = "Based on MBProgressHUD"
ss.description      = <<-DESC
Crash Exception Handler
DESC

ss.homepage         = "https://github.com/leocll/AppBasics.git"
ss.license          = { :type => "MIT", :file => "LICENSE" }
ss.author           = { "leocll" => "leocll@qq.com" }
ss.source           = { :git => "https://github.com/leocll/AppBasics.git", :branch => 'master' }
ss.source_files     = "AppBasic/CLLHud/**/*.{h,m}"
ss.resources        = "AppBasic/CLLHud/CLLHudResources.bundle"
ss.ios.deployment_target = "8.0"

end
