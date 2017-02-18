//
//  JJSBaseNetwork.swift
//  JJSwiftNetwork
//
//  Created by JJ on 2/17/17.
//  Copyright © 2017 jianjing. All rights reserved.
//

import UIKit

import Alamofire

public class JJSBaseNetwork: NSObject {
    
    var successCompletionBlock: ((JJSBaseNetwork) -> Void)?
    var failureCompletionBlock: ((JJSBaseNetwork) -> Void)?

    var hostURL: String!
    var pathURL: String?
    var parameters: [String: Any]?
    var httpHeaders: [String: String]?
    
    lazy var httpMethod: HTTPMethod = .get
    
    var response: HTTPURLResponse?
    var responseStatusCode: Int { return (self.response?.statusCode)! }
    var responseString: String?
    var responseError: Error?
    
    var responseHeaders: [String: String] = [:]
    
    open func start() {
        let request = Alamofire.request("https://httpbin.org/delete", method: httpMethod, parameters: parameters, encoding: URLEncoding.default, headers: httpHeaders)
        
        let requestComplete: (HTTPURLResponse?, Result<String>) -> Void = { response, result in
            self.handleRequestResult(response, result)
        }
        
        request.responseString { response in
            requestComplete(response.response, response.result)
        }
    }
    
    open func stop() {
        
    }
    
    open func requestCompleteFilter() {
        
    }
    
    open func requestFailedFilter() {
        
    }
    
    func buildRequestURL() -> String {
        return ""
    }
    
    func handleRequestResult(_ response: HTTPURLResponse?, _ result: Result<String>) {
        
        self.responseString = result.value
        self.responseError = result.error
        
        
        self.response = response
        if let response = self.response {
            for (field, value) in response.allHeaderFields {
                self.responseHeaders["\(field)"] = "\(value)"
            }
        }
        
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
        if !result {
            return result
        }
        
        return result
        // jsonValidator
    }
    
    func statusCodeValidator() -> Bool {
        let statusCode = self.responseStatusCode
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
