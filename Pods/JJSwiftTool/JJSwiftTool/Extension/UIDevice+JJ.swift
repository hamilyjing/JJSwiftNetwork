//
//  UIDevice+JJ.swift
//  PANewToapAPP
//
//  Created by paux on 16/9/26.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import Foundation
import UIKit
import CoreTelephony

enum YZTHardware : Int {
    case NOT_AVAILABLE
    case IPHONE_2G
    case IPHONE_3G
    case IPHONE_3GS
    case IPHONE_4
    case IPHONE_4_CDMA
    case IPHONE_4S
    case IPHONE_5
    case IPHONE_5_CDMA_GSM
    case IPHONE_5C
    case IPHONE_5C_CDMA_GSM
    case IPHONE_5S
    case IPHONE_5S_CDMA_GSM
    case IPHONE_6_PLUS
    case IPHONE_6
    case IPHONE_6S
    case IPHONE_6S_PLUS
    case IPHONE_SE
    case IPHONE_7
    case IPHONE_7_PLUS
    case IPOD_TOUCH_1G
    case IPOD_TOUCH_2G
    case IPOD_TOUCH_3G
    case IPOD_TOUCH_4G
    case IPOD_TOUCH_5G
    case IPAD
    case IPAD_2
    case IPAD_2_WIFI
    case IPAD_2_CDMA
    case IPAD_3
    case IPAD_3G
    case IPAD_3_WIFI
    case IPAD_3_WIFI_CDMA
    case IPAD_4
    case IPAD_4_WIFI
    case IPAD_4_GSM_CDMA
    case IPAD_MINI
    case IPAD_MINI_WIFI
    case IPAD_MINI_WIFI_CDMA
    case IPAD_MINI_RETINA_WIFI
    case IPAD_MINI_RETINA_WIFI_CDMA
    case IPAD_MINI_3_WIFI
    case IPAD_MINI_3_WIFI_CELLULAR
    case IPAD_MINI_RETINA_WIFI_CELLULAR_CN
    case IPAD_AIR_WIFI
    case IPAD_AIR_WIFI_GSM
    case IPAD_AIR_WIFI_CDMA
    case IPAD_AIR_2_WIFI
    case IPAD_AIR_2_WIFI_CELLULAR
    case IOS_SIMULATOR
}

extension UIDevice {
    
    //MARK: -- Device type
    public static func jjs_isiPhone() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == .phone
    }
    
    public static func jjs_isiPad() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == .pad
    }
    
    //MARK: -- Device orientation
    public static func jjs_currentDeviceLandscapeOrientation() -> Bool {
        return UIDeviceOrientationIsLandscape(UIDevice.current.orientation)
    }
    
    public static func jjs_currentDevicePortraitOrientation() -> Bool {
        return UIDeviceOrientationIsPortrait(UIDevice.current.orientation)
    }
    
    public static func jjs_currentDeviceOrientationDescription() -> String {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            return "landscape"
        }else {
            return "portrait"
        }
    }
    
    public static func jjs_currentInterfaceLandscapeOrientation() -> Bool {
        return UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)
    }
    
    public static func jjs_currentInterfacePortraitOrientation() -> Bool {
        return UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation)
    }
    
    public static func jjs_currentInterfaceOrientationDescription() -> String {
        if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) {
            return "landscape"
        }else {
            return "portrait"
        }
    }
    
    //MARK: -- Bundle info
    public static func jjs_bundleInfoDictionary() -> [String : Any]? {
        return Bundle.main.infoDictionary
    }
    
    public static func jjs_appName() -> String? {
        return UIDevice.jjs_bundleInfoDictionary()?["CFBundleName"] as? String
    }
    
    public static func jjs_bundleIdentifier() -> String? {
        return UIDevice.jjs_bundleInfoDictionary()?["CFBundleIdentifier"] as? String
    }
    
    public static func jjs_appVersion() -> String? {
        let configuredVersion = UserDefaults.standard.value(forKey: "kCustomAppVersion")
        if let configuredVersionValue = configuredVersion {
            if configuredVersionValue is String {
                return (configuredVersionValue as! String)
            }
        }
        return UIDevice.jjs_bundleInfoDictionary()?["CFBundleShortVersionString"] as? String
    }
    
    public static func jjs_appBuildVersion() -> String? {
        return UIDevice.jjs_bundleInfoDictionary()?["CFBundleVersion"] as? String
    }
    
    //MARK: -- Hardware
    public static func jjs_getSysInfoByName(aTypeSpecifier: UnsafePointer<Int8>!) -> String? {
        var size = 0
        sysctlbyname(aTypeSpecifier, nil, &size, nil, 0)
        var results: String? = nil
        
        if size > 0 {
            var answer = [CChar](repeating:0, count: Int(size))
            sysctlbyname(aTypeSpecifier, &answer, &size, nil, 0)
            results = String.init(cString: answer)
        }
        return results
    }
    
    public static func jjs_platform() -> String? {
        return UIDevice.jjs_getSysInfoByName(aTypeSpecifier: "hw.machine")
    }
    
    //---- !!
    public static func jjs_platformDescription() -> String? {
        let hardware = UIDevice.jjs_platform()
        if let hardwareValue = hardware {
            if (hardwareValue == "iPhone1,1") {
                return "iPhone 2G"
            }
            if (hardwareValue == "iPhone1,2") {
                return "iPhone 3G"
            }
            if (hardwareValue == "iPhone2,1") {
                return "iPhone 3GS"
            }
            if (hardwareValue == "iPhone3,1") {
                return "iPhone 4 (GSM)"
            }
            if (hardwareValue == "iPhone3,2") {
                return "iPhone 4 (GSM Rev. A)"
            }
            if (hardwareValue == "iPhone3,3") {
                return "iPhone 4 (CDMA)"
            }
            if (hardwareValue == "iPhone4,1") {
                return "iPhone 4S"
            }
            if (hardwareValue == "iPhone5,1") {
                return "iPhone 5 (GSM)"
            }
            if (hardwareValue == "iPhone5,2") {
                return "iPhone 5 (Global)"
            }
            if (hardwareValue == "iPhone5,3") {
                return "iPhone 5C (GSM)"
            }
            if (hardwareValue == "iPhone5,4") {
                return "iPhone 5C (Global)"
            }
            if (hardwareValue == "iPhone6,1") {
                return "iPhone 5s (GSM)"
            }
            if (hardwareValue == "iPhone6,2") {
                return "iPhone 5s (Global)"
            }
            if (hardwareValue == "iPhone7,1") {
                return "iPhone 6 Plus"
            }
            if (hardwareValue == "iPhone7,2") {
                return "iPhone 6"
            }
            if (hardwareValue == "iPhone8,1") {
                return "iPhone 6s"
            }
            if (hardwareValue == "iPhone8,2") {
                return "iPhone 6s Plus"
            }
            if (hardwareValue == "iPhone8,3") {
                return "iPhone SE"
            }
            if (hardwareValue == "iPhone8,4") {
                return "iPhone SE"
            }
            if (hardwareValue == "iPhone9,1") {
                return "iPhone 7"
            }
            if (hardwareValue == "iPhone9,2") {
                return "iPhone 7 Plus"
            }
            
            if (hardwareValue == "iPod1,1") {
                return "iPod Touch (1 Gen)"
            }
            if (hardwareValue == "iPod2,1") {
                return "iPod Touch (2 Gen)"
            }
            if (hardwareValue == "iPod3,1") {
                return "iPod Touch (3 Gen)"
            }
            if (hardwareValue == "iPod4,1") {
                return "iPod Touch (4 Gen)"
            }
            if (hardwareValue == "iPod5,1") {
                return "iPod Touch (5 Gen)"
            }
            
            
            if (hardwareValue == "iPad1,1") {
                return "iPad (WiFi)"
            }
            if (hardwareValue == "iPad1,2") {
                return "iPad 3G"
            }
            if (hardwareValue == "iPad2,1") {
                return "iPad 2 (WiFi)"
            }
            if (hardwareValue == "iPad2,2") {
                return "iPad 2 (GSM)"
            }
            if (hardwareValue == "iPad2,3") {
                return "iPad 2 (CDMA)"
            }
            if (hardwareValue == "iPad2,4") {
                return "iPad 2 (WiFi Rev. A)"
            }
            if (hardwareValue == "iPad2,5") {
                return "iPad Mini (WiFi)"
            }
            if (hardwareValue == "iPad2,6") {
                return "iPad Mini (GSM)"
            }
            if (hardwareValue == "iPad2,7") {
                return "iPad Mini (CDMA)"
            }
            if (hardwareValue == "iPad3,1") {
                return "iPad 3 (WiFi)"
            }
            if (hardwareValue == "iPad3,2") {
                return "iPad 3 (CDMA)"
            }
            if (hardwareValue == "iPad3,3") {
                return "iPad 3 (Global)"
            }
            if (hardwareValue == "iPad3,4") {
                return "iPad 4 (WiFi)"
            }
            if (hardwareValue == "iPad3,5") {
                return "iPad 4 (CDMA)"
            }
            if (hardwareValue == "iPad3,6") {
                return "iPad 4 (Global)"
            }
            if (hardwareValue == "iPad4,1") {
                return "iPad Air (WiFi)"
            }
            if (hardwareValue == "iPad4,2") {
                return "iPad Air (WiFi+GSM)"
            }
            if (hardwareValue == "iPad4,3") {
                return "iPad Air (WiFi+CDMA)"
            }
            if (hardwareValue == "iPad4,4") {
                return "iPad Mini Retina (WiFi)"
            }
            if (hardwareValue == "iPad4,5") {
                return "iPad Mini Retina (WiFi+CDMA)"
            }
            if (hardwareValue == "iPad4,6") {
                return "iPad Mini Retina (Wi-Fi + Cellular CN)"
            }
            if (hardwareValue == "iPad4,7") {
                return "iPad Mini 3 (Wi-Fi)"
            }
            if (hardwareValue == "iPad4,8") {
                return "iPad Mini 3 (Wi-Fi + Cellular)"
            }
            if (hardwareValue == "iPad5,3") {
                return "iPad Air 2 (Wi-Fi)"
            }
            if (hardwareValue == "iPad5,4") {
                return "iPad Air 2 (Wi-Fi + Cellular)"
            }
            
            if (hardwareValue == "i386") {
                return "iOS_Simulator"
            }
            if (hardwareValue == "x86_64") {
                return "iOS_Simulator"
            }
            if hardwareValue.hasPrefix("iPhone") {
                return "iPhone"
            }
            if hardwareValue.hasPrefix("iPod") {
                return "iPod"
            }
            if hardwareValue.hasPrefix("iPad") {
                return "iPad"
            }
        }
        return nil
    }
    
    //---- !!
    public static func jjs_platformSimpleDescription() -> String? {
        let hardware = UIDevice.jjs_platform()
        if let hardwareValue = hardware {
            if (hardwareValue == "iPhone1,1") {
                return "iPhone 2G"
            }
            if (hardwareValue == "iPhone1,2") {
                return "iPhone 3G"
            }
            if (hardwareValue == "iPhone2,1") {
                return "iPhone 3GS"
            }
            if (hardwareValue == "iPhone3,1") {
                return "iPhone 4"
            }
            if (hardwareValue == "iPhone3,2") {
                return "iPhone 4"
            }
            if (hardwareValue == "iPhone3,3") {
                return "iPhone 4"
            }
            if (hardwareValue == "iPhone4,1") {
                return "iPhone 4S"
            }
            if (hardwareValue == "iPhone5,1") {
                return "iPhone 5 (GSM)"
            }
            if (hardwareValue == "iPhone5,2") {
                return "iPhone 5"
            }
            if (hardwareValue == "iPhone5,3") {
                return "iPhone 5C"
            }
            if (hardwareValue == "iPhone5,4") {
                return "iPhone 5C"
            }
            if (hardwareValue == "iPhone6,1") {
                return "iPhone 5s"
            }
            if (hardwareValue == "iPhone6,2") {
                return "iPhone 5s"
            }
            if (hardwareValue == "iPhone7,1") {
                return "iPhone 6 Plus"
            }
            if (hardwareValue == "iPhone7,2") {
                return "iPhone 6"
            }
            if (hardwareValue == "iPhone8,1") {
                return "iPhone 6s"
            }
            if (hardwareValue == "iPhone8,2") {
                return "iPhone 6s Plus"
            }
            if (hardwareValue == "iPhone8,3") {
                return "iPhone SE"
            }
            if (hardwareValue == "iPhone8,4") {
                return "iPhone SE"
            }
            if (hardwareValue == "iPhone9,1") {
                return "iPhone 7"
            }
            if (hardwareValue == "iPhone9,2") {
                return "iPhone 7 Plus"
            }
            
            if (hardwareValue == "iPod1,1") {
                return "iPod Touch (1 Gen)"
            }
            if (hardwareValue == "iPod2,1") {
                return "iPod Touch (2 Gen)"
            }
            if (hardwareValue == "iPod3,1") {
                return "iPod Touch (3 Gen)"
            }
            if (hardwareValue == "iPod4,1") {
                return "iPod Touch (4 Gen)"
            }
            if (hardwareValue == "iPod5,1") {
                return "iPod Touch (5 Gen)"
            }
            
            
            if (hardwareValue == "iPad1,1") {
                return "iPad"
            }
            if (hardwareValue == "iPad1,2") {
                return "iPad"
            }
            if (hardwareValue == "iPad2,1") {
                return "iPad 2"
            }
            if (hardwareValue == "iPad2,2") {
                return "iPad 2"
            }
            if (hardwareValue == "iPad2,3") {
                return "iPad 2"
            }
            if (hardwareValue == "iPad2,4") {
                return "iPad 2"
            }
            if (hardwareValue == "iPad2,5") {
                return "iPad Mini"
            }
            if (hardwareValue == "iPad2,6") {
                return "iPad Mini"
            }
            if (hardwareValue == "iPad2,7") {
                return "iPad Mini"
            }
            if (hardwareValue == "iPad3,1") {
                return "iPad 3"
            }
            if (hardwareValue == "iPad3,2") {
                return "iPad 3"
            }
            if (hardwareValue == "iPad3,3") {
                return "iPad 3"
            }
            if (hardwareValue == "iPad3,4") {
                return "iPad 4"
            }
            if (hardwareValue == "iPad3,5") {
                return "iPad 4"
            }
            if (hardwareValue == "iPad3,6") {
                return "iPad 4"
            }
            if (hardwareValue == "iPad4,1") {
                return "iPad Air"
            }
            if (hardwareValue == "iPad4,2") {
                return "iPad Air"
            }
            if (hardwareValue == "iPad4,3") {
                return "iPad Air"
            }
            if (hardwareValue == "iPad4,4") {
                return "iPad Mini Retina"
            }
            if (hardwareValue == "iPad4,5") {
                return "iPad Mini Retina"
            }
            if (hardwareValue == "iPad4,6") {
                return "iPad Mini Retina"
            }
            if (hardwareValue == "iPad4,7") {
                return "iPad Mini 3"
            }
            if (hardwareValue == "iPad4,8") {
                return "iPad Mini 3"
            }
            if (hardwareValue == "iPad5,3") {
                return "iPad Air 2"
            }
            if (hardwareValue == "iPad5,4") {
                return "iPad Air 2"
            }
            
            if (hardwareValue == "i386") {
                return "iOS_Simulator"
            }
            if (hardwareValue == "x86_64") {
                return "iOS_Simulator"
            }
            if hardwareValue.hasPrefix("iPhone") {
                return "iPhone"
            }
            if hardwareValue.hasPrefix("iPod") {
                return "iPod"
            }
            if hardwareValue.hasPrefix("iPad") {
                return "iPad"
            }
        }
        return nil
    }
    
    //---- !!
    static func jjs_hardware() -> YZTHardware {
        let hardware = UIDevice.jjs_platform()
        if let hardwareValue = hardware {
            if (hardwareValue == "iPhone1,1") {
                return .IPHONE_2G
            }
            if (hardwareValue == "iPhone1,2") {
                return .IPHONE_3G
            }
            if (hardwareValue == "iPhone2,1") {
                return .IPHONE_3GS
            }
            if (hardwareValue == "iPhone3,1") {
                return .IPHONE_4
            }
            if (hardwareValue == "iPhone3,2") {
                return .IPHONE_4
            }
            if (hardwareValue == "iPhone3,3") {
                return .IPHONE_4_CDMA
            }
            if (hardwareValue == "iPhone4,1") {
                return .IPHONE_4S
            }
            if (hardwareValue == "iPhone5,1") {
                return .IPHONE_5
            }
            if (hardwareValue == "iPhone5,2") {
                return .IPHONE_5_CDMA_GSM
            }
            if (hardwareValue == "iPhone5,3") {
                return .IPHONE_5C
            }
            if (hardwareValue == "iPhone5,4") {
                return .IPHONE_5C_CDMA_GSM
            }
            if (hardwareValue == "iPhone6,1") {
                return .IPHONE_5S
            }
            if (hardwareValue == "iPhone6,2") {
                return .IPHONE_5S_CDMA_GSM
            }
            if (hardwareValue == "iPhone7,1") {
                return .IPHONE_6_PLUS
            }
            if (hardwareValue == "iPhone7,2") {
                return .IPHONE_6
            }
            if (hardwareValue == "iPhone8,1") {
                return .IPHONE_6S
            }
            if (hardwareValue == "iPhone8,2") {
                return .IPHONE_6S_PLUS
            }
            if (hardwareValue == "iPhone8,3") {
                return .IPHONE_SE
            }
            if (hardwareValue == "iPhone8,4") {
                return .IPHONE_SE
            }
            if (hardwareValue == "iPhone9,1") {
                return .IPHONE_7
            }
            if (hardwareValue == "iPhone9,2") {
                return .IPHONE_7_PLUS
            }
            
            if (hardwareValue == "iPod1,1") {
                return .IPOD_TOUCH_1G
            }
            if (hardwareValue == "iPod2,1") {
                return .IPOD_TOUCH_2G
            }
            if (hardwareValue == "iPod3,1") {
                return .IPOD_TOUCH_3G
            }
            if (hardwareValue == "iPod4,1") {
                return .IPOD_TOUCH_4G
            }
            if (hardwareValue == "iPod5,1") {
                return .IPOD_TOUCH_5G
            }
            
            
            if (hardwareValue == "iPad1,1") {
                return .IPAD
            }
            if (hardwareValue == "iPad1,2") {
                return .IPAD_3G
            }
            if (hardwareValue == "iPad2,1") {
                return .IPAD_2_WIFI
            }
            if (hardwareValue == "iPad2,2") {
                return .IPAD_2
            }
            if (hardwareValue == "iPad2,3") {
                return .IPAD_2_CDMA
            }
            if (hardwareValue == "iPad2,4") {
                return .IPAD_2
            }
            if (hardwareValue == "iPad2,5") {
                return .IPAD_MINI_WIFI
            }
            if (hardwareValue == "iPad2,6") {
                return .IPAD_MINI
            }
            if (hardwareValue == "iPad2,7") {
                return .IPAD_MINI_WIFI_CDMA
            }
            if (hardwareValue == "iPad3,1") {
                return .IPAD_3_WIFI
            }
            if (hardwareValue == "iPad3,2") {
                return .IPAD_3_WIFI_CDMA
            }
            if (hardwareValue == "iPad3,3") {
                return .IPAD_3
            }
            if (hardwareValue == "iPad3,4") {
                return .IPAD_4_WIFI
            }
            if (hardwareValue == "iPad3,5") {
                return .IPAD_4
            }
            if (hardwareValue == "iPad3,6") {
                return .IPAD_4_GSM_CDMA
            }
            if (hardwareValue == "iPad4,1") {
                return .IPAD_AIR_WIFI
            }
            if (hardwareValue == "iPad4,2") {
                return .IPAD_AIR_WIFI_GSM
            }
            if (hardwareValue == "iPad4,3") {
                return .IPAD_AIR_WIFI_CDMA
            }
            if (hardwareValue == "iPad4,4") {
                return .IPAD_MINI_RETINA_WIFI
            }
            if (hardwareValue == "iPad4,5") {
                return .IPAD_MINI_RETINA_WIFI_CDMA
            }
            if (hardwareValue == "iPad4,6") {
                return .IPAD_MINI_RETINA_WIFI_CELLULAR_CN
            }
            if (hardwareValue == "iPad4,7") {
                return .IPAD_MINI_3_WIFI
            }
            if (hardwareValue == "iPad4,8") {
                return .IPAD_MINI_3_WIFI_CELLULAR
            }
            if (hardwareValue == "iPad5,3") {
                return .IPAD_AIR_2_WIFI
            }
            if (hardwareValue == "iPad5,4") {
                return .IPAD_AIR_2_WIFI_CELLULAR
            }
            
            if (hardwareValue == "i386") {
                return .IOS_SIMULATOR
            }
            if (hardwareValue == "x86_64") {
                return .IOS_SIMULATOR
            }
            if hardwareValue.hasPrefix("iPhone") {
                return .IOS_SIMULATOR
            }
            if hardwareValue.hasPrefix("iPod") {
                return .IOS_SIMULATOR
            }
            if hardwareValue.hasPrefix("iPad") {
                return .IOS_SIMULATOR
            }
        }
        return YZTHardware.NOT_AVAILABLE;
    }
    
    //---- !!
    static func yzt_hardwareNumber(hardware: YZTHardware) -> Float {
        switch hardware {
        case .IPHONE_2G:
            return 1.1
        case .IPHONE_3G:
            return 1.2
        case .IPHONE_3GS:
            return 2.1
        case .IPHONE_4:
            return 3.1
        case .IPHONE_4_CDMA:
            return 3.3
        case .IPHONE_4S:
            return 4.1
        case .IPHONE_5:
            return 5.1
        case .IPHONE_5_CDMA_GSM:
            return 5.2
        case .IPHONE_5C:
            return 5.3
        case .IPHONE_5C_CDMA_GSM:
            return 5.4
        case .IPHONE_5S:
            return 6.1
        case .IPHONE_5S_CDMA_GSM:
            return 6.2
        case .IPHONE_6_PLUS:
            return 7.1
        case .IPHONE_6:
            return 7.2
        case .IPHONE_6S_PLUS:
            return 8.2
        case .IPHONE_6S:
            return 8.1
        case .IPHONE_SE:
            return 8.3
        case .IPHONE_7:
            return 9.1
        case .IPHONE_7_PLUS:
            return 9.2
        case .IPOD_TOUCH_1G:
            return 1.1
        case .IPOD_TOUCH_2G:
            return 2.1
        case .IPOD_TOUCH_3G:
            return 3.1
        case .IPOD_TOUCH_4G:
            return 4.1
        case .IPOD_TOUCH_5G:
            return 5.1
        case .IPAD:
            return 1.1
        case .IPAD_3G:
            return 1.2
        case .IPAD_2_WIFI:
            return 2.1
        case .IPAD_2:
            return 2.2
        case .IPAD_2_CDMA:
            return 2.3
        case .IPAD_MINI_WIFI:
            return 2.5
        case .IPAD_MINI:
            return 2.6
        case .IPAD_MINI_WIFI_CDMA:
            return 2.7
        case .IPAD_3_WIFI:
            return 3.1
        case .IPAD_3_WIFI_CDMA:
            return 3.2
        case .IPAD_3:
            return 3.3
        case .IPAD_4_WIFI:
            return 3.4
        case .IPAD_4:
            return 3.5
        case .IPAD_4_GSM_CDMA:
            return 3.6
        case .IPAD_AIR_WIFI:
            return 4.1
        case .IPAD_AIR_WIFI_GSM:
            return 4.2
        case .IPAD_AIR_WIFI_CDMA:
            return 4.3
        case .IPAD_AIR_2_WIFI:
            return 5.3
        case .IPAD_AIR_2_WIFI_CELLULAR:
            return 5.4
        case .IPAD_MINI_RETINA_WIFI:
            return 4.4
        case .IPAD_MINI_RETINA_WIFI_CDMA:
            return 4.5
        case .IPAD_MINI_3_WIFI:
            return 4.6
        case .IPAD_MINI_3_WIFI_CELLULAR:
            return 4.7
        case .IPAD_MINI_RETINA_WIFI_CELLULAR_CN:
            return 4.8
        case .IOS_SIMULATOR:
            return 100.0
        case .NOT_AVAILABLE:
            return 200.0
        }
    }
    
    //---- !!
    public static func jjs_backCameraStillImageResolutionInPixels() -> CGSize {
        switch UIDevice.jjs_hardware() {
        case .IPHONE_2G,.IPHONE_3G:
            return CGSize(width: 1600, height: 1200)
        case .IPHONE_3GS:
            return CGSize(width: 2048, height: 1536)
        case .IPHONE_4,.IPHONE_4_CDMA,.IPAD_3_WIFI,.IPAD_3_WIFI_CDMA,.IPAD_3,.IPAD_4_WIFI,.IPAD_4,.IPAD_4_GSM_CDMA:
            return CGSize(width: 2592, height: 1936)
        case .IPHONE_4S,.IPHONE_5,.IPHONE_5_CDMA_GSM,.IPHONE_5C,.IPHONE_5C_CDMA_GSM,.IPHONE_6,.IPHONE_6_PLUS,.IPHONE_6S,.IPHONE_6S_PLUS:
            return CGSize(width: 3264, height: 2448)
        case .IPOD_TOUCH_4G:
            return CGSize(width: 960, height: 720)
        case .IPOD_TOUCH_5G:
            return CGSize(width: 2440, height: 1605)
        case .IPAD_2_WIFI,.IPAD_2,.IPAD_2_CDMA:
            return CGSize(width: 872, height: 720)
        case .IPAD_MINI_WIFI,.IPAD_MINI,.IPAD_MINI_WIFI_CDMA:
            return CGSize(width: 1820, height: 1304)
        case .IPAD_AIR_2_WIFI,.IPAD_AIR_2_WIFI_CELLULAR:
            return CGSize(width: 1536, height: 2048)
        default:
            //print("We have no resolution for your device's camera listed in this category. Please, make photo with back camera of your device, get its resolution in pixels (via Preview Cmd+I for example) and add a comment to this repository (https://github.com/InderKumarRathore/UIDeviceUtil) on GitHub.com in format Device = Hpx x Wpx.")
            return CGSize.zero
        }
    }
    
    public static func jjs_systemName() -> String {
        return UIDevice.current.systemName
    }
    
    public static func jjs_systemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    //---- !!
    public static func jjs_macAddress() -> String {
        return ""
    }
    
    //---- !!
    public static func jjs_IPAdress() -> String {
        return ""
    }
    
    //MARK: -- Memory
    public static func yzt_realMemory() -> Double {
        return (Double(ProcessInfo.processInfo.physicalMemory) / 1024.0 / 1024.0)
    }
    
    //---- !!
    public static func jjs_availableMemory() -> Double {
        return 0.0
    }
    
    //---- !!
    public static func jjs_usedMemory() -> Double {
        return 0.0
    }
    
    //MARK: -- 运营商信息
    public static func yzt_mobileCountryCode() -> String? {
        let netInfo = CTTelephonyNetworkInfo.init()
        let carrier = netInfo.subscriberCellularProvider
        return carrier?.mobileCountryCode
    }
    
    public static func jjs_mobileNetworkCode() -> String? {
        let netInfo = CTTelephonyNetworkInfo.init()
        let carrier = netInfo.subscriberCellularProvider
        return carrier?.mobileNetworkCode
    }
    
    public static func jjs_allowsVOIP() -> Bool {
        let netInfo = CTTelephonyNetworkInfo.init()
        let carrier = netInfo.subscriberCellularProvider
        if let carrierValue = carrier {
            return carrierValue.allowsVOIP
        }
        return false
    }
    
    public static func jjs_carrierName() -> String? {
        let netInfo = CTTelephonyNetworkInfo.init()
        let carrier = netInfo.subscriberCellularProvider
        return carrier?.carrierName
    }
    
    public static func jjs_isoCountryCode() -> String? {
        let netInfo = CTTelephonyNetworkInfo.init()
        let carrier = netInfo.subscriberCellularProvider
        return carrier?.isoCountryCode
    }
    
    public static func jjs_currentRadioAccessTechnology() -> String? {
        let netInfo = CTTelephonyNetworkInfo.init()
        return netInfo.currentRadioAccessTechnology
    }
    
    //MARK: -- JailBreak
    public static func yzt_isJailBreak() -> Bool {
        var jailbroken = false
        let cydiaPath = "/Applications/Cydia.app"
        let aptPath = "/private/var/lib/apt/"
        if FileManager.default.fileExists(atPath: cydiaPath) {
            jailbroken = true
        }
        if FileManager.default.fileExists(atPath: aptPath) {
            jailbroken = true
        }
        return jailbroken
    }
    
    //MARK: -- Screen
    public static var isZoomed: Bool {
        if Int(UIScreen.main.scale.rounded()) == 3 {
            // Plus-sized
            return UIScreen.main.nativeScale > 2.7
        } else {
            return UIScreen.main.nativeScale > UIScreen.main.scale
        }
    }
    
    public static func jjs_screenSizeIgnoreDisplayZoom() -> CGSize {
        // 弥补iPhone 6和iPhone 6 Plus中的“设置”->“显示与亮度”->"显示模式"对[UIScreen mainScreen].bounds.size的影响
        switch UIDevice.jjs_hardware() {
        case .IPHONE_SE:
            return CGSize(width: 320, height: 568)
        case .IPHONE_6,.IPHONE_6S,.IPHONE_7:
            return CGSize(width: 375, height: 667)
        case .IPHONE_6_PLUS,.IPHONE_6S_PLUS,.IPHONE_7_PLUS:
            return CGSize(width: 414, height: 736)
        default:
            var size = UIScreen.main.bounds.size
            if UIDevice.isZoomed {
                size.width = size.width / UIScreen.main.scale
                size.height = size.height / UIScreen.main.scale
            }
            return size;
        }
    }
    
    public static func jjs_screenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
    
    public static func jjs_screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    public static func jjs_screenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
}
