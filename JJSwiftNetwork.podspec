Pod::Spec.new do |s|

  s.name         = "JJSwiftNetwork"
  s.version      = "1.0.2"
  s.summary      = "iOS swift network framework"
  s.homepage     = "https://github.com/hamilyjing/JJSwiftNetwork"
  s.license      = "MIT"
  s.author             = { "JJ" => "gongjian_001@126.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/hamilyjing/JJSwiftNetwork.git", :tag => s.version }
  s.source_files  = "JJSwiftNetwork", "JJSwiftNetwork/**/*.{swift,h,m}"

  s.dependency "CryptoSwift", "~> 0.6.7"
  s.dependency "Alamofire", "~> 4.3.0"
  s.dependency "SwiftyJSON", "~> 3.1.4"
  s.dependency "HandyJSON", "~> 1.5.2"
  s.dependency "JJSwiftTool"

end
