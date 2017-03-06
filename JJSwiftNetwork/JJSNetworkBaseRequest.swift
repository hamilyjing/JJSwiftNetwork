//
//  JJSNetworkBaseRequest.swift
//  JJSwiftNetwork
//
//  Created by JJ on 2/17/17.
//  Copyright © 2017 jianjing. All rights reserved.
//

import UIKit

import Alamofire

open class JJSNetworkBaseRequest {
    
    public var successCompletionBlock: ((JJSNetworkBaseRequest) -> Void)?
    public var failureCompletionBlock: ((JJSNetworkBaseRequest) -> Void)?
    
    public var httpRequest: Request?
    public var httpParameters: [String: Any]?
    public var httpMethod: HTTPMethod = .get
    
    public var response: HTTPURLResponse?
    public var responseString: String?
    public var responseError: Error?
    public var responseStatusCode: Int? {
        if let response = response {
            return response.statusCode
        } else {
            return nil
        }
    }
    public var responseHeaders: [String: String]? {
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
    
    func start(successCompletionBlock: ((JJSNetworkBaseRequest) -> Void)?, failureCompletionBlock: ((JJSNetworkBaseRequest) -> Void)?) {
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
    
    open func filterResponseString() -> String? {
        return responseString
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
