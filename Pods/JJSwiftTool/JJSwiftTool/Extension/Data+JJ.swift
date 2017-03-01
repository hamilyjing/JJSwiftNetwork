//
//  Data+JJ.swift
//  PANewToapAPP
//
//  Created by jincieryi on 16/9/23.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import Foundation

extension Data {
    public func jjs_string() -> String? {
        return String(data: self, encoding: .utf8)
    }
    
    public func jjs_jsonObject() -> Any? {
        var object: Any?
        
        do {
            object = try JSONSerialization.jsonObject(with:self, options: [])
        } catch {
            assert(object != nil, "From data to JSON object error:\(error.localizedDescription)");
        }
        
        return object
    }
    
    public func jjs_array() -> Array<Any>? {
        return self.jjs_jsonObject() as? Array
    }
    
    public func jjs_dictionary() -> Dictionary<AnyHashable,Any>? {
        return self.jjs_jsonObject() as? Dictionary
    }
}
