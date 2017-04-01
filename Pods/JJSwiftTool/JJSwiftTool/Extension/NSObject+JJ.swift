//
//  NSObject+JJ.swift
//  JJSwiftTool
//
//  Created by JJ on 3/14/17.
//  Copyright © 2017 jianjing. All rights reserved.
//

import Foundation

extension NSObject {
    
    public func jjs_encode(with aCoder: NSCoder) {
        NSObject.jjs_forEachChildOfMirror(reflecting: self) { key in
            aCoder.encode(value(forKey: key), forKey: key)
        }
    }
    
    public func jjs_decode(coder aDecoder: NSCoder) {
        NSObject.jjs_forEachChildOfMirror(reflecting: self) { key in
            setValue(aDecoder.decodeObject(forKey: key), forKey: key)
        }
    }
    
    public class func jjs_forEachChildOfMirror(reflecting subject: Any, handler: (String) -> Void) {
        var mirror: Mirror? = Mirror(reflecting: subject)
        while mirror != nil {
            for child in mirror!.children {
                if let key = child.label {
                    handler(key)
                }
            }
            
            // Get super class's properties.
            mirror = mirror!.superclassMirror
        }
    }
}
