//
//  NSDictionary+JJ.swift
//  PANewToapAPP
//
//  Created by 周结兵 on 16/9/18.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import Foundation
import UIKit

extension Dictionary {
    //key的value值是否有
    public func jjs_hasKey(key: Key) -> Bool {
        return (self[key] != nil)
    }
    
    //key的value值转为Int型
    public func jjs_intForKey(key:Key) -> Int? {
        let value = Int.jjs_convertIntegerToInt(self[key])
        if value != nil {
            return value
        }
        if (self[key] is String)
        {
            let value = Int(self[key] as! String)
            return value
        }
        return nil
    }
    
    //key的value值转为float型
    public func jjs_floatForKey(key: Key) -> Float? {
        if self[key] is Float {
            return self[key] as? Float;
        } else if self[key] is Double {
            return Float(self[key] as! Double);
        } else if self[key] is Integer {
            return Float(Int.jjs_convertIntegerToInt(self[key])!);
        } else if self[key] is String {
            return Float(self[key] as! String);
        }
        return nil
    }
    
    //key的value值转为Double型
    public func jjs_doubleForKey(key: Key) -> Double? {
        if self[key] is Double {
            return self[key] as? Double;
        } else if self[key] is Float {
            return Double(self[key] as! Float);
        } else if self[key] is Integer {
            return Double(Int.jjs_convertIntegerToInt(self[key])!);
        } else if self[key] is String {
            return Double(self[key] as! String);
        }
        return nil;
    }

    //key的value值转为bool型
    public func jjs_boolForKey(key:Key) -> Bool? {
        return self[key] as? Bool
    }
    
    //与OC的转换成Int型一样的效果 
    public func jjs_OC_intForKey(key:Key) -> Int? {
        if (self[key] is String) {
            let newValue = Double(self[key] as! String)
            if newValue == nil {
                return nil
            }else {
                return Int(newValue!)
            }
        }else if(self[key] is Double || self[key] is Float) {
            let str = NSString(format: "%f" , self[key] as! CVarArg)
            return str.integerValue
        }else if(self[key] is Int) {
            return self[key] as? Int
        }else if(self[key] is CLongLong) {
            let str = NSString(format: "%ld" , self[key] as! CVarArg)
            return str.integerValue
        }
        return nil
    }
    
    //与OC的转换成Float型一样的效果
    public func jjs_OC_floatForKey(key: Key) -> Float? {
        if (self[key] is String) {
            let newValue = Double(self[key] as! String)
            if newValue == nil {
                return nil
            }else {
                return Float(newValue!)
            }
        }else if(self[key] is Double || self[key] is Float) {
            let str = NSString(format: "%f" , self[key] as! CVarArg)
            return str.floatValue
        }else if(self[key] is Int) {
            let str = NSString(format: "%d" , self[key] as! CVarArg)
            return str.floatValue
        }else if(self[key] is CLongLong) {
            let str = NSString(format: "%ld" , self[key] as! CVarArg)
            return str.floatValue
        }
        return nil
    }
    
    //与OC的转换成Double型一样的效果
    public func jjs_OC_doubleForKey(key: Key) -> Double? {
        if (self[key] is String) {
            let newValue = Double(self[key] as! String)
            if newValue == nil {
                return nil
            }else {
                return Double(newValue!)
            }
        }else if(self[key] is Double || self[key] is Float) {
            let str = NSString(format: "%f" , self[key] as! CVarArg)
            return str.doubleValue
        }else if(self[key] is Int) {
            let str = NSString(format: "%d" , self[key] as! CVarArg)
            return str.doubleValue
        }else if(self[key] is CLongLong) {
            let str = NSString(format: "%ld" , self[key] as! CVarArg)
            return str.doubleValue
        }
        return nil
    }
    
    //key的value值是array
    public func jjs_arrayForKey(key:Key) -> [Any]? {
        if self[key] is [Any]
        {
            return self[key] as? [Any]
        }
        return nil
    }
    
    //key的value值是Dictionary
    public func jjs_dictionaryForKey(key:Key) -> Dictionary? {
        if self[key] is Dictionary{
            return self[key] as? Dictionary
        }
        return nil
    }
    
    //字典的key与value交换,value必须是可哈希的才能交换
    public func jjs_exchangeKeyAndValue() -> [AnyHashable:Any]? {
        var newDic = Dictionary() as [AnyHashable:Any]
        for (key, value) in self {
            if value is AnyHashable {
                newDic[value as! AnyHashable] = key
            }else {
                return nil;
            }
        }
        return newDic
    }
    
    //字典合并,如果有相同的key,value取后面字典的值
    public func jjs_dictionaryByMerging(dict1:[AnyHashable:Any],dict2:[AnyHashable:Any]) -> [AnyHashable:Any]? {
        var newDic = dict1
        for (key, value) in dict2 {
            newDic[key] = value
        }
        return newDic
    }
    
    //字典合并,如果有相同的key,value取自己的值
    public func jjs_dictionaryByMergingWith(dict1:[AnyHashable:Any]) -> [AnyHashable:Any]? {
        var newDic = dict1
        for (key, value) in self {
            newDic[key] = value
        }
        return newDic
    }
    
    //字典的key排序 true 升序 false 降序,注:字典的key的类型必须是一样的,如果不一样排序无规则
    public func jjs_keyListBySortLongKey(ascendingOrder:Bool) -> [Any] {
        if ascendingOrder {
            let new = Array(self.keys).sorted(by:{ (s1, s2) -> Bool in
                if s1 is String && s2 is String
                {
                    let str1 = s1 as! String
                    let str2 = s2 as! String
                    return str1 < str2
                } else if s1 is Int && s2 is Int {
                    let str1 = s1 as! Int
                    let str2 = s2 as! Int
                    return str1 < str2
                } else if s1 is Double && s2 is Double {
                    let str1 = s1 as! Double
                    let str2 = s2 as! Double
                    return str1 < str2
                } else if s1 is Float && s2 is Float {
                    let str1 = s1 as! Float
                    let str2 = s2 as! Float
                    return str1 < str2
                } else {
                   return false
                }
            }
            )
            return new
        }else {
            let new = Array(self.keys).sorted(by:{ (s1, s2) -> Bool in
                if s1 is String && s2 is String
                {
                    let str1 = s1 as! String
                    let str2 = s2 as! String
                    return str1 > str2
                } else if s1 is Int && s2 is Int {
                    let str1 = s1 as! Int
                    let str2 = s2 as! Int
                    return str1 > str2
                } else if s1 is Double && s2 is Double {
                    let str1 = s1 as! Double
                    let str2 = s2 as! Double
                    return str1 > str2
                } else if s1 is Float && s2 is Float {
                    let str1 = s1 as! Float
                    let str2 = s2 as! Float
                    return str1 > str2
                } else {
                   return false
                }
            }
            )
            return new

        }
    }
    
}
