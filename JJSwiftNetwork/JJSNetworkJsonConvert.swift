//
//  JJSNetworkJsonConvert.swift
//  JJSwiftNetwork
//
//  Created by JJ on 3/3/17.
//  Copyright © 2017 jianjing. All rights reserved.
//

import UIKit

import SwiftyJSON
import HandyJSON

public protocol JJSNetworkJsonConvertProtocol {
    
    func convertToObject(jsonObject: Any) -> JJSNetworkBaseObjectProtocol?
    
    func deserializeFrom(jsonString: String?) -> JJSNetworkBaseObjectProtocol?
}

public class JJSNetworkJsonConvert<T: JJSNetworkBaseObjectProtocol>: JJSNetworkJsonConvertProtocol {
    
    public init() {
    }
    
    public func convertToObject(jsonObject: Any) -> JJSNetworkBaseObjectProtocol? {
        var resultObject: T?
        
        switch jsonObject {
        case let object as [String : Any] where object.count > 0:
            resultObject = JSONDeserializer<T>.deserializeFrom(dict: object as NSDictionary?)
        case let object as [Any] where object.count > 0:
            let json = JSON(object)
            let jsonString = json.rawString()
            let objectArray = JSONDeserializer<T>.deserializeModelArrayFrom(json: jsonString)
            var resultArray = [T]()
            if let tempObjectArray = objectArray {
                for item in tempObjectArray {
                    if let tempItem = item {
                        resultArray.append(tempItem)
                    }
                }
            }
            resultObject = T.init()
            resultObject?.responseResultArray = resultArray
        case let object as String:
            resultObject = T.init()
            resultObject?.responseResultString = object
        default:
            resultObject = T.init()
        }
        
        return resultObject
    }
    
    public func deserializeFrom(jsonString: String?) -> JJSNetworkBaseObjectProtocol? {
        var object = JSONDeserializer<T>.deserializeFrom(json: jsonString)
        if nil == object {
            return nil
        }
        
        if let array = object!.responseResultArray {
            var resultArray = [T]()
            for item in array {
                let tempObject = JSONDeserializer<T>.deserializeFrom(dict: item as? NSDictionary)
                resultArray.append(tempObject!)
            }
            if resultArray.count > 0 {
                object!.responseResultArray = resultArray
            }
        }
        
        return object
    }
}
