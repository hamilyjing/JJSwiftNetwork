//
//  JJSBaseNetworkRequest.swift
//  JJSwiftNetwork
//
//  Created by JJ on 2/17/17.
//  Copyright © 2017 jianjing. All rights reserved.
//

import UIKit

import Alamofire

open class JJSBaseNetworkRequest {
    
    var successCompletionBlock: ((JJSBaseNetworkRequest) -> Void)?
    var failureCompletionBlock: ((JJSBaseNetworkRequest) -> Void)?
    
    var httpRequest: Request?
    var httpParameters: [String: Any]?
    var httpMethod: HTTPMethod = .get
    
    var response: HTTPURLResponse?
    var responseString: String?
    var responseError: Error?
    var responseStatusCode: Int? {
        if let response = response {
            return response.statusCode
        } else {
            return nil
        }
    }
    var responseHeaders: [String: String]? {
        if let response = response {
            var headers = [String: String]()
            for (field, value) in response.allHeaderFields {
                headers["\(field)"] = "\(value)"
            }
            return headers
        } else {
            return nil
        }
    }
    
    open func requestHostURL() -> String {
        return ""
    }
    
    open func requestPathURL() -> String {
        return ""
    }
    
    open func requestParameters() -> [String: Any]? {
        return httpParameters
    }
    
    open func requestHeaders() -> [String: String]? {
        return nil
    }
    
    open func requestTimeoutInterval() -> TimeInterval {
        return 60
    }
    
    open func start() {
        stop()
        
        let requestComplete: (HTTPURLResponse?, Result<String>) -> Void = { response, result in
            self.handleRequestResult(response, result)
        }
        
        SessionManager.default.session.configuration.timeoutIntervalForRequest = requestTimeoutInterval()
        
        let request = Alamofire.request(buildRequestURL(), method: httpMethod, parameters: requestParameters(), encoding: URLEncoding.default, headers: requestHeaders())
        request.responseString { response in
            requestComplete(response.response, response.result)
        }
        
        self.httpRequest = request
    }
    
    func start(successCompletionBlock: ((JJSBaseNetworkRequest) -> Void)?, failureCompletionBlock: ((JJSBaseNetworkRequest) -> Void)?) {
        self.successCompletionBlock = successCompletionBlock
        self.failureCompletionBlock = failureCompletionBlock
        
        start()
    }
    
    open func stop() {
        self.httpRequest?.cancel()
    }
    
    open func requestCompleteFilter() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "JJSwiftNetworkResponseSuccess"), object: responseString)
    }
    
    open func requestFailedFilter() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "JJSwiftNetworkResponseFail"), object: responseString)
    }
    
    open func buildRequestURL() -> String {
        let urlString = requestHostURL() + requestPathURL()
        return urlString
    }
    
    func handleRequestResult(_ response: HTTPURLResponse?, _ result: Result<String>) {
        self.response = response
        self.responseString = result.value
        self.responseError = result.error
        
        let succeed = checkResult()
        if succeed {
            requestCompleteFilter()
            if let successCompletionBlock = self.successCompletionBlock {
                successCompletionBlock(self)
            }
        } else {
            requestFailedFilter()
            if let failureCompletionBlock = self.failureCompletionBlock {
                failureCompletionBlock(self)
            }
        }
        
        clearCompletionBlock()
    }
    
    func checkResult() -> Bool {
        let result = statusCodeValidator()
        return result
    }
    
    func statusCodeValidator() -> Bool {
        guard responseStatusCode != nil else {
            return false
        }
        
        let statusCode = self.responseStatusCode!
        if statusCode >= 200 && statusCode <= 299 {
            return true
        } else {
            return false
        }
    }
    
    func clearCompletionBlock() {
        successCompletionBlock = nil
        failureCompletionBlock = nil
    }
}
