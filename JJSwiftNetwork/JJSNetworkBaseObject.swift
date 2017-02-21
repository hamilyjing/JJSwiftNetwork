//
//  JJSNetworkBaseObject.swift
//  iOS Example
//
//  Created by JJ on 2/21/17.
//  Copyright © 2017 Alamofire. All rights reserved.
//

import UIKit

protocol JJSNetworkBaseObjectProtocol {
    
    func successForBussiness()
    
    func responseMessage() -> String
    
    var responseResultArray: Array<Any>? { get set }
    var responseResultString: String? { get set }
}

extension JJSNetworkBaseObjectProtocol {
    
    func successForBussiness() -> Bool {
        return false
    }
    
    func responseMessage() -> String {
        return ""
    }
}
