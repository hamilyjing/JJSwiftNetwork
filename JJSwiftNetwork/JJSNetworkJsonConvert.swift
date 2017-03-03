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
    
    func getConvertObjectContent(_ resoponseDic: [String : Any]) -> Any
    func convertToObject(jsonString: String?) -> JJSNetworkBaseObjectProtocol?
    
    func deserializeFrom(jsonString: String?) -> JJSNetworkBaseObjectProtocol?
}

public class JJSNetworkJsonConvert<T: JJSNetworkBaseObjectProtocol>: JJSNetworkJsonConvertProtocol {
    
    public func getConvertObjectContent(_ resoponseDic: [String : Any]) -> Any {
        return resoponseDic;
    }
    
    public func convertToObject(jsonString: String?) -> JJSNetworkBaseObjectProtocol? {
        guard jsonString != nil else {
            return nil
        }
        
        let json = JSON(parseJSON: jsonString!)
        let resoponseDic = json.dictionaryObject
        if nil == resoponseDic {
            return nil
        }
        
        let convertObject = getConvertObjectContent(resoponseDic!)
        
        var resultObject: T?
        
        switch convertObject {
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
        
        if let object = resultObject {
            object.setData(resoponseDic!)
            return object
        } else {
            return nil
        }
    }
    
    public func deserializeFrom(jsonString: String?) -> JJSNetworkBaseObjectProtocol? {
        let object = JSONDeserializer<T>.deserializeFrom(json: jsonString)
        return object
    }
}
