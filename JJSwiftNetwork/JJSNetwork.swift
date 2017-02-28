//
//  JJSNetwork.swift
//  iOS Example
//
//  Created by JJ on 2/20/17.
//  Copyright © 2017 Alamofire. All rights reserved.
//

import UIKit

import HandyJSON
import SwiftyJSON

//class JJWeatherModel1: JJSNetworkBaseObject, HandyJSON {
//    
//    var errNum: Int64?
//    var errMsg: String?
//    
//    required override init() {}
//}

class JJSNetwork<T: HandyJSON & JJSNetworkBaseObjectProtocol>: JJSBaseNetwork {
    
    var objectClass: JJSNetworkBaseObjectProtocol?
    
    var isSaveToMemory: Bool = false
    var isSaveToDisk: Bool = false
    
    private var oldCacheObject: JJSNetworkBaseObjectProtocol?
    private var newCacheObject: JJSNetworkBaseObjectProtocol?
    
    var operation: ((JJSNetworkBaseObjectProtocol?, JJSNetworkBaseObjectProtocol?) -> JJSNetworkBaseObjectProtocol?)?
    
    override init() {
        
    }
    
    // MARK: -
    // MARK: overwrite
    
    override func requestCompleteFilter() {
        
        if !isSaveToMemory && !isSaveToDisk {
            return
        }
        
        oldCacheObject = cacheObject()
        var newObject = convertToObject(filterResponseString())
        
        newObject = responseOperation(newObject: newObject, oldObject: oldCacheObject)
        
        if !successForBussiness(newObject) {
            return
        }
        
        if isSaveToMemory {
            newCacheObject = newObject
        }
        
        if isSaveToDisk {
            saveObjectToDisk(newObject!)
        }
    }
    
    override func requestFailedFilter() {
        
    }
    
    // MARK: -
    // MARK: response operation
    
    open func getConvertObjectContent(_ resoponseDic: [String : Any]) -> Any {
        return resoponseDic;
    }
    
    open func convertToObject(_ resoponseString: String?) -> JJSNetworkBaseObjectProtocol? {
        
        guard resoponseString != nil else {
            return nil
        }
        
        let json = JSON(parseJSON: resoponseString!)
        let resoponseDic = json.dictionaryObject
        guard resoponseDic != nil else {
            return nil
        }
        
        let convertContentDic = getConvertObjectContent(resoponseDic!)
        
        var resultObject: T?
        
        switch convertContentDic {
        case let object as [String : Any] where object.count > 0:
            resultObject = JSONDeserializer<T>.deserializeFrom(dict: object as NSDictionary?)
        case let object as [Any] where object.count > 0:
            let json = JSON(object)
            resultObject = T.init()
            resultObject?.responseResultArray = JSONDeserializer<T>.deserializeModelArrayFrom(json: json.string)
        case _ as String:
            resultObject = T.init()
            resultObject?.responseResultString = resoponseString
        default:
            resultObject = T.init()
        }
        
//        let stringg = "[{\"errNum\": 300202,\"errMsg\": \"Missingapikey\"},{\"errNum\": 300202,\"errMsg\": \"Missingapikey\"}]"
//        let dd = JSONDeserializer<JJWeatherModel1>.deserializeModelArrayFrom(json: stringg)
//        if let tt = dd {
//            print(tt.count)
//        }
//        
//        let json1 = JSON(parseJSON: stringg)
//        let resoponseDic1 = json1.dictionaryObject
//        let resoponseArray1 = json1.array
//        let resoponseArray2 = json1.arrayValue
//        let resoponseArray3 = json1.arrayObject
//        let ddd: [String : Any]? = resoponseArray3?[0] as? [String : Any]
//        if let yyy = ddd {
//            print("")
//        }

        
        
        
//        if let object = aa {
//            object.responseMessage()
//        }
        
        if let object = resultObject {
            object.setData(resoponseDic!)
            return object
        } else {
            return nil
        }
    }
    
    open func responseOperation(newObject: JJSNetworkBaseObjectProtocol?, oldObject: JJSNetworkBaseObjectProtocol?) -> JJSNetworkBaseObjectProtocol? {
        if let responseOperation = operation {
            return responseOperation(newObject, oldObject)
        }
        
        return newObject
    }
    
    open func successForBussiness(_ objct: JJSNetworkBaseObjectProtocol?) -> Bool {
        
        if let object = objct {
            return object.successForBussiness()
        }
        return false
    }
    
    // MARK: -
    // MARK: cache file config
    
    open func cacheFilePath() -> String {
        return cacheFileDirectory() + cacheFileName()
    }
    
    open func cacheFileDirectory() -> String {
        return ""
    }
    
    open func cacheFileName() -> String {
        return ""
    }
    
    // MARK: -
    // MARK: cache operation
    
    open func cacheObject() -> JJSNetworkBaseObjectProtocol? {
        return nil
    }
    
    open func currentResponseObject() -> JJSNetworkBaseObjectProtocol? {
        
        var object = convertToObject(filterResponseString())
        object = responseOperation(newObject: object, oldObject: oldCacheObject)
        return object
    }
    
    open func saveObjectToMemory(_ object: Any) {
    }
    
    open func saveObjectToDisk(_ object: Any) {
    }
    
    open func haveDiskCache() -> Bool {
        return false
    }
    
    open func removeMemoryCache(_ object: Any) {
    }

    open func removeDiskCache(_ object: Any) {
    }

    open func removeAllCache(_ object: Any) {
    }
}
