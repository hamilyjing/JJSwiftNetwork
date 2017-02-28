//
//  JJSNetworkBaseObject.swift
//  iOS Example
//
//  Created by JJ on 2/21/17.
//  Copyright © 2017 Alamofire. All rights reserved.
//

import UIKit

public protocol JJSNetworkBaseObjectProtocol {
    
    var responseResultArray: Array<Any>? { get set }
    var responseResultString: String? { get set }
    
    func successForBussiness() -> Bool
    
    func responseMessage() -> String
    
    func setData(_ content: [String: Any]) -> Void
}

extension JJSNetworkBaseObjectProtocol {
    
    public func successForBussiness() -> Bool {
        return false
    }
    
    public func responseMessage() -> String {
        return ""
    }
    
    public func setData(_ content: [String: Any]) -> Void {
        
    }
}

open class JJSNetworkBaseObject: JJSNetworkBaseObjectProtocol {
    
    public var responseResultArray: Array<Any>?
    public var responseResultString: String?
}
