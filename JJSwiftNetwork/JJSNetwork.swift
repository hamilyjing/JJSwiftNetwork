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
import JJSwiftTool

open class JJSNetwork: JJSBaseNetwork {
    
    var isSaveToMemory: Bool = false
    var isSaveToDisk: Bool = false
    
    private var oldCacheObject: JJSNetworkBaseObjectProtocol?
    private var newCacheObject: JJSNetworkBaseObjectProtocol?
    
    var userCacheDirectory: String?
    var sensitiveDataForSavedFileName: String?
    var parametersForSavedFileName: [String: Any]?
    var identity: String?
    
    var operation: ((JJSNetworkBaseObjectProtocol?, JJSNetworkBaseObjectProtocol?) -> JJSNetworkBaseObjectProtocol?)?
    
    var convertObject: JJSNetworkConvertObjectProtocol?
    
    // MARK: -
    // MARK: lifecycle
    
    override init() {
    }
    
    required public init(parameters: [String: Any]?, identity: String?, isSaveToMemory: Bool, isSaveToDisk: Bool, convertObject: JJSNetworkConvertObjectProtocol?) {
        super.init()
        
        self.httpParameters = parameters
        self.identity = identity
        self.isSaveToMemory = isSaveToMemory
        self.isSaveToDisk = isSaveToDisk
        self.parametersForSavedFileName = self.httpParameters
        self.convertObject = convertObject
    }
    
    // MARK: -
    // MARK: overwrite
    
    override open func requestCompleteFilter() {
        super.requestCompleteFilter()
        
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
            saveObjectToDisk(newObject)
        }
    }
    
    override open func requestFailedFilter() {
        super.requestFailedFilter()
        
        processAbnormalStatus()
    }
    
    // MARK: -
    // MARK: response operation
    
    open func filterResponseString() -> String? {
        return responseString
    }
    
    open func getConvertObjectContent(_ resoponseDic: [String : Any]) -> Any {
        return resoponseDic;
    }
    
    open func convertToObject(_ resoponseString: String?) -> JJSNetworkBaseObjectProtocol? {
        return self.convertObject?.convertToObject(jsonString: resoponseString)
    }
    
    open func responseOperation(newObject: JJSNetworkBaseObjectProtocol?, oldObject: JJSNetworkBaseObjectProtocol?) -> JJSNetworkBaseObjectProtocol? {
        if let responseOperation = operation {
            return responseOperation(newObject, oldObject)
        }
        
        return newObject
    }
    
    open func successForBussiness(_ objct: JJSNetworkBaseObjectProtocol?) -> Bool {
        if let tempObject = objct {
            return tempObject.successForBussiness()
        }
        return false
    }
    
    open func processAbnormalStatus() {
    }
    
    // MARK: -
    // MARK: cache file config
    
    open func cacheFilePath() -> String {
        return cacheFileDirectory() + "/" + cacheFileName()
    }
    
    open func cacheFileDirectory() -> String {
        var cachesDirectory = FileManager.jjs_cachesDirectory()
        cachesDirectory += "/JJSwiftNetwork"
        
        if let userCacheDirectory = self.userCacheDirectory {
            cachesDirectory += "/" + userCacheDirectory
        }
        
        let flag = FileManager.jjs_createDirectoryAtPath(path: cachesDirectory)
        assert(flag)
        
        return cachesDirectory
    }
    
    open func cacheFileName() -> String {
        var cacheFileName: String = ""
        
        if let sensitiveData = sensitiveDataForSavedFileName {
            cacheFileName += sensitiveData + "_"
        } else {
            cacheFileName += "AllAccount" + "_"
        }
        
        if let identity = identity {
            cacheFileName += identity + "_"
        }
        
        let parameters = self.parametersForSavedFileName ?? [String: Any]()
        let parametersString = "Parameters:\(parameters)"
        let parametersStringMd5 = parametersString.jjs_md5String()
        cacheFileName += parametersStringMd5
        
        return cacheFileName
    }
    
    // MARK: -
    // MARK: cache operation
    
    open func cacheObject() -> JJSNetworkBaseObjectProtocol? {
        if newCacheObject != nil {
            return newCacheObject
        }
        
        let filePath = cacheFilePath()
        let data = FileManager.default.contents(atPath: filePath)
        if nil == data {
            return nil
        }
        
        let savedString = data!.jjs_string()
        let object = self.convertObject?.deserializeFrom(jsonString: savedString)
        
        if isSaveToMemory {
            newCacheObject = object
        }
        
        return object
    }
    
    open func currentResponseObject() -> JJSNetworkBaseObjectProtocol? {
        var object = convertToObject(filterResponseString())
        object = responseOperation(newObject: object, oldObject: oldCacheObject)
        return object
    }
    
    open func saveObjectToMemory(_ object: JJSNetworkBaseObjectProtocol?) {
        newCacheObject = object
    }
    
    open func saveObjectToDisk(_ object: JJSNetworkBaseObjectProtocol?) {
        guard object != nil else {
            return
        }
        
        let filePath = cacheFilePath()
        let encodeString = object!.encodeString()
        guard encodeString != nil else {
            return
        }
        
        do
        {
            try encodeString!.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
        }
        catch let error as NSError
        {
            assert(false, "error\(error.localizedDescription)")
        }
    }
    
    open func haveDiskCache() -> Bool {
        return FileManager.jjs_isFileExistAtPath(fileFullPath: cacheFilePath())
    }
    
    open func removeMemoryCache() {
        newCacheObject = nil
        oldCacheObject = nil
    }

    open func removeDiskCache() {
        do{
            try FileManager.default.removeItem(atPath: cacheFilePath())
        } catch let error as NSError {
            assert(false, "error\(error.localizedDescription)")
        }
    }

    open func removeAllCache(_ object: Any) {
        removeMemoryCache()
        removeDiskCache()
    }
}
