//
//  Timer+JJ.swift
//  PANewToapAPP
//
//  Created by 周结兵 on 16/10/10.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import Foundation
import UIKit

public typealias TimerExcuteClosure = @convention(block)()->()

extension Timer {
    
    //这个方法在swift3.0之前可以用,swift3.0的timer.scheduledTimer方法中 target 由3.0之前的版本AnyObject变为3.0的Any
    //不会再引起循环引用了,只要页面销毁之前调用timer.invalidate() 就会被释放掉
    /*public class func jjs_scheduledTimerWithTimeInterval(ti:TimeInterval, closure:TimerExcuteClosure, repeats yesOrNo: Bool) -> Timer {
     return self.scheduledTimer(timeInterval: ti, target: self, selector: #selector(excuteTimerClosure(timer:)), userInfo: unsafeBitCast(closure, to: AnyObject.self), repeats: true)
     }
     
     class func excuteTimerClosure(timer: Timer)
     {
     let closure = unsafeBitCast(timer.userInfo, to: TimerExcuteClosure.self)
     closure()
     
     }*/
    
    //swift 创建timer之后会直接开始定时器,这个方法创建完了不会开始,需要手动写代码触发开始
    public class func jjs_scheduledTimer(timeInterval: TimeInterval, target: Any, selector: Selector, userInfo: Any?, repeats: Bool) ->Timer {
        let newTimer = self.scheduledTimer(timeInterval: timeInterval, target: target, selector: selector, userInfo: userInfo, repeats: repeats)
        newTimer.jjs_pause()
        return newTimer
    }
    
    public func jjs_start() {
        self.fireDate = Date.distantPast
    }
    
    public func jjs_pause() {
        self.fireDate = Date.distantFuture
    }
    
    public func jjs_stop() {
        self.invalidate()
    }
}
