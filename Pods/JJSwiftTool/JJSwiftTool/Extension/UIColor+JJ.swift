//
//  UIColor+JJ.swift
//  PANewToapAPP
//
//  Created by jincieryi on 16/9/20.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import UIKit

extension UIColor {
    fileprivate convenience init?(hex6: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat( (hex6 & 0xFF0000) >> 16 ) / 255.0,
                  green: CGFloat( (hex6 & 0x00FF00) >> 8 ) / 255.0,
                  blue: CGFloat( (hex6 & 0x0000FF) >> 0 ) / 255.0, alpha: CGFloat(alpha))
    }
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    public convenience init?(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    public convenience init?(hex: Int, alpha: CGFloat = 1.0) {
        if (0x000000 ... 0xFFFFFF) ~= hex {
            self.init(hex6: hex , alpha: alpha)
        } else {
            return nil
        }
    }
    
    public convenience init?(hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }
    
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        formatted = formatted.replacingOccurrences(of: " ", with: "")
        
        guard let hexVal = Int(formatted, radix: 16) else {
            return nil
        }
        
        switch formatted.characters.count {
        case 6:
            self.init(hex6: hexVal, alpha: alpha)
        default:
            return nil
        }
    }
    
    public static func jjs_colorWithHex(hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(hex: hex, alpha: alpha)!
    }
    
    public static func jjs_colorWithHexString(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(hexString: hexString, alpha: alpha)!
    }
    
    public static func jjs_arc4randomColor(_ randomAlpha: Bool = false) -> UIColor {
        return UIColor(r: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), g: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), b: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), a: (randomAlpha ? (CGFloat(Float(arc4random()) / Float(UINT32_MAX))) : 1.0))
    }
}
