//
//  JJSNetworkBaseObject.swift
//  iOS Example
//
//  Created by JJ on 2/21/17.
//  Copyright © 2017 Alamofire. All rights reserved.
//

import UIKit

public protocol JJSNetworkBaseObjectProtocol {
    
    func successForBussiness() -> Bool
    
    func responseMessage() -> String
    
    var responseResultArray: Array<Any>? { get set }
    var responseResultString: String? { get set }
}

extension JJSNetworkBaseObjectProtocol {
    
    public func successForBussiness() -> Bool {
        return false
    }
    
    public func responseMessage() -> String {
        return ""
    }
}

open class JJSNetworkBaseObject: JJSNetworkBaseObjectProtocol {
    
    public var responseResultArray: Array<Any>?
    public var responseResultString: String?
}
