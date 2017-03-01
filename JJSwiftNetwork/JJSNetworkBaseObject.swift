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
    
    func stringForSave() -> String?
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
    
    open func stringForSave() -> String? {
        return nil
    }
}
