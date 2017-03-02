//
//  JJSNetworkBaseObject.swift
//  iOS Example
//
//  Created by JJ on 2/21/17.
//  Copyright © 2017 Alamofire. All rights reserved.
//

import UIKit

import HandyJSON

public protocol JJSNetworkBaseObjectProtocol: HandyJSON {
    
    var responseResultArray: [Any]? { get set }
    var responseResultString: String? { get set }
    
    func successForBussiness() -> Bool
    
    func responseMessage() -> String
    
    func setData(_ content: [String: Any]) -> Void
    
    func encodeString() -> String?
}

open class JJSNetworkBaseObject: JJSNetworkBaseObjectProtocol {
    
    public var responseResultArray: Array<Any>?
    public var responseResultString: String?
    
    open func successForBussiness() -> Bool {
        return false
    }
    
    open func responseMessage() -> String {
        return ""
    }
    
    open func setData(_ content: [String: Any]) -> Void {
    }
    
    open func encodeString() -> String? {
        return self.toJSONString()
    }
    
    public required init() {
    }
}
