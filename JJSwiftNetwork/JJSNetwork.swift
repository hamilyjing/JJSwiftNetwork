//
//  JJSNetwork.swift
//  iOS Example
//
//  Created by JJ on 2/20/17.
//  Copyright © 2017 Alamofire. All rights reserved.
//

import UIKit

class JJSNetwork: JJSBaseNetwork {
    
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
        
        if let object = newObject {
            if !object.successForBussiness() {
                return
            }
        } else {
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
    
    open func convertToObject(_ resoponseString: String?) -> JJSNetworkBaseObjectProtocol? {
        return nil
    }
    
    open func responseOperation(newObject: JJSNetworkBaseObjectProtocol?, oldObject: JJSNetworkBaseObjectProtocol?) -> JJSNetworkBaseObjectProtocol? {
        if let responseOperation = operation {
            return responseOperation(newObject, oldObject)
        }
        
        return nil
    }
    
    open func successForBussiness(_ objct: Any?) -> Bool {
        return false
    }
    
    // MARK: -
    // MARK: cache file config
    
    open func cacheFilePath() -> String {
        return ""
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
