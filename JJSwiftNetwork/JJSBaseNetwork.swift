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

    var hostURL: String!
    var pathURL: String?
    var parameters: [String: Any]?
    var httpHeaders: [String: String]?
    
    lazy var httpMethod: HTTPMethod = .get
    
    var response: HTTPURLResponse?
    
    public func start() {
        let request = Alamofire.request("https://httpbin.org/delete", method: httpMethod, parameters: parameters, encoding: URLEncoding.default, headers: httpHeaders)
        
        let requestComplete: (HTTPURLResponse?, Result<String>) -> Void = { response, result in
        }
        
        if let request = request as? DataRequest {
            request.responseString { response in
                requestComplete(response.response, response.result)
            }
        } else if let request = request as? DownloadRequest {
            request.responseString { response in
                requestComplete(response.response, response.result)
            }
        }
    }
    
    public func stop() {
        
    }
    
    func buildRequestURL() -> String {
        return ""
    }
}
