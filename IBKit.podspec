Pod::Spec.new do |s|
  s.name         = "IBKit"
  s.version      = "0.3.0"
  s.license      = "MIT"
  s.summary      = "A declarative style interface builder in Swift"
  s.homepage     = "https://github.com/IBCodeKit/IBKit"
  s.author       = { "Nate Kim" => "glwithu06@gmail.com" }
  s.source       = { :git => "https://github.com/IBCodeKit/IBKit.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/**/*.swift"
  s.weak_framework = "SwiftUI"
  s.ios.deployment_target = "11.0"
end