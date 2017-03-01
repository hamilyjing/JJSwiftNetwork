//
//  UILabel+JJ.swift
//  PANewToapAPP
//
//  Created by 周结兵 on 16/10/18.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    //转换AnyHashable成string类型展示
    public func jjs_textToString(text:AnyHashable?) {
        if text == nil {
            self.text = nil
        } else {
            self.text = String(describing: text!)
        }
    }
    
    //MARK: label部分属性设置
    public func jjs_init(text:AnyHashable?, textAlignment:NSTextAlignment?) {
        self.jjs_initAllProperty(frame: nil, text: text, textAlignment: textAlignment, fontSize: nil, textColor: nil, backgroundColor: nil)
    }
    
    public func jjs_init(text:AnyHashable?, textAlignment:NSTextAlignment?, fontSize:Float?) {
        self.jjs_initAllProperty(frame: nil, text: text, textAlignment: textAlignment, fontSize: fontSize, textColor: nil, backgroundColor: nil)
    }
    
    public func jjs_init(text:AnyHashable?, textAlignment:NSTextAlignment?, fontSize:Float?, textColor:UIColor?) {
        self.jjs_initAllProperty(frame: nil, text: text, textAlignment: textAlignment, fontSize: fontSize, textColor: textColor, backgroundColor: nil)
    }
    
    public func jjs_init(text:AnyHashable?, textAlignment:NSTextAlignment?, fontSize:Float?,
                          textColor:UIColor?, backgroundColor:UIColor?) {
        self.jjs_initAllProperty(frame: nil, text: text, textAlignment: textAlignment, fontSize: fontSize, textColor: textColor, backgroundColor: backgroundColor)
    }
    
    //设置label的所有属性
    public func jjs_initAllProperty(frame:CGRect?, text:AnyHashable?, textAlignment:NSTextAlignment?, fontSize:Float?,
                                     textColor:UIColor?, backgroundColor:UIColor?) {
        if frame != nil {
            self.frame = frame!
        }
        if text != nil {
            self.jjs_textToString(text: text)
        }
        if textAlignment != nil {
            self.textAlignment = textAlignment!
        }
        if fontSize != nil {
            self.font = UIFont.systemFont(ofSize: CGFloat(fontSize!))
        }
        if textColor != nil {
            self.textColor = textColor!
        }
        if backgroundColor != nil {
            self.backgroundColor = backgroundColor
        }
    }
}
