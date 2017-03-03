//
//  JJSService.swift
//  JJSwiftNetwork
//
//  Created by JJ on 3/3/17.
//  Copyright © 2017 jianjing. All rights reserved.
//

import UIKit

open class JJSService: NSObject {
    
    open func startRequest(request: JJSNetworkRequest, successAction: ((JJSNetworkBaseObjectProtocol, JJSNetworkRequest) -> Void)? = nil, failAcction: ((Error, JJSNetworkRequest) -> Void)? = nil) {
        request.successCompletionBlock = { baseRequest in
            let object = request.currentResponseObject()!
            successAction?(object, request)
            
            self.handleResponseResult(success: true, object: object, request: request)
        }
        
        request.failureCompletionBlock = { baseRequest in
            let error = request.responseError
            failAcction?(error!, request)
            
            self.handleResponseResult(success: false, object:nil, request: request)
        }
        
        request.start()
    }
    
    open func responseCallBack(success: Bool, object: JJSNetworkBaseObjectProtocol?, request: JJSNetworkRequest) {
        var result: JJSResult<JJSNetworkBaseObjectProtocol>
        if success {
            result = JJSResult<JJSNetworkBaseObjectProtocol>.success(object!)
        } else {
            result = JJSResult<JJSNetworkBaseObjectProtocol>.failure(request.responseError!)
        }
        request.responseCallback?(result, request.otherInfo)
    }
    
    open func postResponseNotification(success: Bool, object: JJSNetworkBaseObjectProtocol?, request: JJSNetworkRequest) {
        var userInfo = [String: Any]()
        userInfo["success"] = success
        userInfo["identity"] = request.identity
        userInfo["parameter"] = request.httpParameters
        userInfo["object"] = object
        userInfo["error"] = request.responseError
        userInfo["otherInfo"] = request.otherInfo
        
        let notificationName = "\(self.classForCoder)_\(request.identity != nil ? request.identity! : request.buildRequestURL())"
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationName), object: self, userInfo: userInfo)
    }
    
    open func handleResponseResult(success: Bool, object: JJSNetworkBaseObjectProtocol?, request: JJSNetworkRequest) {
        responseCallBack(success: success, object: object, request: request)
        postResponseNotification(success: success, object: object, request: request)
    }
}
