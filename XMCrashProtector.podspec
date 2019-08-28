Pod::Spec.new do |s|

  s.name         = "XMCrashProtector"
  s.version      = "1.0.3"
  s.summary      = "This is a crash protection component"

  s.description  = <<-DESC
                    XMCrashProtector Handle the objective-c crash exception.
                   DESC

  s.homepage     = "https://github.com/SmatMing/XMCrashProtector"

  s.license      = "MIT"

  s.author             = { "SmatMing" => "fzyxuming@163.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/SmatMing/XMCrashProtector.git", :tag => "#{s.version}" }

  s.source_files  = "XMCrashProtector", "XMCrashProtector/**/*.{h,m}"


end
