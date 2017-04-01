platform :ios, '8.0'
use_frameworks!

def shared_pods
    pod 'CryptoSwift', '~> 0.6.8'
    pod 'Alamofire', '~> 4.3.0'
    pod 'SwiftyJSON', '~> 3.1.4'
    pod 'HandyJSON', '~> 1.6.1'
    pod 'JJSwiftTool'
end

target 'JJSwiftNetwork' do
    project 'JJSwiftNetwork.xcodeproj'
    shared_pods
end

target 'JJSwiftNetworkTests' do
    project 'JJSwiftNetwork.xcodeproj'
    shared_pods
end
