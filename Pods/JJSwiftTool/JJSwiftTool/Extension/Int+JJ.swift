//
//  Int+JJ.swift
//  PANewToapAPP
//
//  Created by JJ on 10/12/16.
//  Copyright © 2016 PingAn. All rights reserved.
//

import Foundation

extension Int {
    public static func jjs_convertIntegerToInt(_ value: Any?) -> Int? {
        guard value != nil && value is Integer else {
            return nil
        }
        
        if (value is Int){
            return value as? Int
        }else if (value is Int8) {
            return Int(value as! Int8)
        }else if (value is UInt8) {
            return Int(value as! UInt8)
        }else if (value is Int16) {
            return Int(value as! Int16)
        }else if (value is UInt16) {
            return Int(value as! UInt16)
        }else if (value is Int32) {
            return Int(value as! Int32)
        }else if (value is UInt32) {
            return Int(value as! UInt32)
        }else if (value is Int64) {
            return Int(value as! Int64)
        }else if (value is UInt64) {
            return Int(value as! UInt64)
        }
        
        assert(false, "Can not convert to Int.");
        return nil
    }
}
