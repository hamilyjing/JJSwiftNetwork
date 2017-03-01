//
//   Array+JJ.swift
//  PANewToapAPP
//
//  Created by LynnLin on 16/9/27.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import Foundation
import UIKit

extension Array {
    
    /*
     *safe method
    */
    public func jjs_object(atIndex: Int) -> Any? {
        if (atIndex < self.count) {
            return self[atIndex] as Any?;
        }
        return nil;
    }
    
    public func jjs_string(atIndex: Int) -> String? {
        let item = jjs_object(atIndex: atIndex);
        return item as? String;
    }

    public func jjs_array(atIndex: Int) -> Array? {
        let item = jjs_object(atIndex: atIndex);
        return item as? Array;
    }

    //不确定字典中key/value类型可以用[AnyHashable: Any]  
    public func jjs_dictionary(atIndex: Int) -> [AnyHashable: Any]?{
        let item = jjs_object(atIndex: atIndex);
        return item as? [AnyHashable: Any];
    }
    

    public func jjs_int(atIndex: Int) -> Int? {
        let item = jjs_object(atIndex: atIndex);
        
        let value = Int.jjs_convertIntegerToInt(item)
        if value != nil {
            return value
        }
        
        if (item is String)
        {
            let value = Int(item as! String)
            return value
        }
        return nil;
    }

    public func jjs_bool(atIndex: Int) -> Bool? {
        let item = jjs_object(atIndex: atIndex);
        return item as? Bool;
    }

    public func jjs_float(atIndex: Int) -> Float? {
        let item = jjs_object(atIndex: atIndex);
        if item is Float {
            return item as? Float;
        }
        if item is Double {
            return Float(item as! Double);
        }
        if item is Integer {
            return Float(Int.jjs_convertIntegerToInt(item)!);
        }
        if item is String {
            return Float(item as! String);
        }
        
        return nil;
    }

    public func jjs_double(atIndex: Int) -> Double? {
        let item = jjs_object(atIndex: atIndex);
        if item is Double {
            return item as? Double;
        }
        if item is Float {
            return Double(item as! Float);
        }
        if item is Integer {
            return Double(Int.jjs_convertIntegerToInt(item)!);
        }
        if item is String {
            return Double(item as! String);
        }
        return nil;
    }
    
    /*
     *Get CG object
     */
    public func jjs_CGFloat(atIndex: Int) -> CGFloat? {
        let item = jjs_object(atIndex: atIndex);
        return item as? CGFloat;
    }
    
    public func jjs_point(atIndex: Int) -> CGPoint? {
        let item = jjs_object(atIndex: atIndex);
        if item is CGPoint {
            return item as? CGPoint;
        }
        if item is String {
            return CGPointFromString(item as! String);
        }
        return nil;
    }
    
    public func jjs_size(atIndex: Int) -> CGSize? {
        let item = jjs_object(atIndex: atIndex);
        if item is CGSize {
            return item as? CGSize;
        }
        if item is String {
            return CGSizeFromString(item as! String);
        }
        return nil;
    }
    
    public func jjs_rect(atIndex: Int) -> CGRect? {
        let item = jjs_object(atIndex: atIndex);
        if item is CGRect {
            return item as? CGRect;
        }
        if item is String {
            return CGRectFromString(item as! String);
        }
        return nil;
    }
    
    /*
     *JSON
     */
    public func jjs_jsonString() -> String? {
        let jsonData: Data? = self.jjs_jsonData();
        if jsonData != nil {
            return String(data: jsonData!, encoding: .utf8)
        }
        return nil;
    }
    
    public func jjs_jsonData() -> Data? {
        var jsonData: Data?
        do {
            jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        }
        catch {
            assert(jsonData == nil, "From array to data error:\(error.localizedDescription)");
        }
        return jsonData;
    }
}
