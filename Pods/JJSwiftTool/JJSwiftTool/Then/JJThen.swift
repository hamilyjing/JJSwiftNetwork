//
//  JJThen.swift
//  PANewToapAPP
//
//  Created by JJ on 16/9/27.
//  Copyright © 2016年 JJ. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

public protocol JJThen {}

extension JJThen where Self: Any {
    
    /// Makes it available to set properties with closures just after initializing and copying the value types.
    ///
    ///     let frame = CGRect().jjWith {
    ///       $0.origin.x = 10
    ///       $0.size.width = 100
    ///     }
    public func jjWith(_ block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
    
    /// Makes it available to execute something with closures.
    ///
    ///     UserDefaults.standard.jjDo {
    ///       $0.set("devxoul", forKey: "username")
    ///       $0.set("devxoul@gmail.com", forKey: "email")
    ///       $0.synchronize()
    ///     }
    public func jjDo(_ block: (Self) -> Void) {
        block(self)
    }
}

extension JJThen where Self: AnyObject {
    
    /// Makes it available to set properties with closures just after initializing.
    ///
    ///     let label = UILabel().jjThen {
    ///       $0.textAlignment = .Center
    ///       $0.textColor = UIColor.blackColor()
    ///       $0.text = "Hello, World!"
    ///     }
    public func jjThen(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: JJThen {}

extension CGPoint: JJThen {}
extension CGRect: JJThen {}
extension CGSize: JJThen {}
extension CGVector: JJThen {}
