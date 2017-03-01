//
//  UIView+JJ.swift
//  PANewToapAPP
//
//  Created by LynnLin on 16/9/28.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /*
     *Frame
    */
    public var jjsWidth: CGFloat {
        get {
            return frame.size.width;
        }
        set {
            frame.size.width = newValue;
        }
    };
    
    public var jjsHeight: CGFloat {
        get {
            return frame.size.height;
        }
        set {
            frame.size.height = newValue;
        }
    };
    
    public var jjsLeft: CGFloat {
        get {
            return frame.origin.x;
        }
        set {
            frame.origin.x = newValue;
        }
    };
    
    public var jjsTop: CGFloat {
        get {
            return frame.origin.y;
        }
        set {
            frame.origin.y = newValue;
        }
    };
    
    public var jjsRight: CGFloat {
        get {
            return frame.origin.x + frame.size.width;
        }
        set {
            frame.origin.x = newValue - frame.size.width;
        }
    };
    
    public var jjsBottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height;
        }
        set {
            frame.origin.y = newValue - frame.size.height;
        }
    }
    
    public var jjsCenterX: CGFloat {
        get {
            return center.x;
        }
        set {
            center.x = newValue;
        }
    };
    
    public var jjsCenterY: CGFloat {
        get {
            return center.y;
        }
        set {
            center.y = newValue;
        }
    };
    
    public var jjsOrigin: CGPoint {
        get {
            return frame.origin;
        }
        set {
            frame.origin = newValue;
        }
    };
    
    public var jjsSize: CGSize {
        get {
            return frame.size;
        }
        set {
            frame.size = newValue;
        }
    };
    
    /*
     *相对屏幕
    */
    
    public var jjsScreenX: CGFloat! {
        get {
            var screenX: CGFloat! = 0.0;
            var view: UIView! = self;
            repeat {
                screenX = screenX + view.jjsLeft;
                view = view.superview;
            } while (view != nil);
            return screenX;
        }
    };
    
    public var jjsScreenY: CGFloat! {
        get {
            var screenY: CGFloat! = 0.0;
            var view: UIView! = self;
            repeat {
                screenY = screenY + view.jjsTop;
                view = view.superview;
            } while (view != nil);
            return screenY;
        }
    };
    
    public var jjsScreenFrame: CGRect! {
        return CGRect.init(x: self.jjsScreenX, y: self.jjsScreenY, width: self.jjsWidth, height: self.jjsHeight);
    }
    
    /*
     *transform
     */
    
    public func jjs_scaleWithSX(sx: CGFloat!, sy: CGFloat!) {
        self.transform = CGAffineTransform.init(scaleX: sx, y: sy);
    }
    
    
    /*
     *line
     */
    public var jjsSingleLineWidth: CGFloat! {
        get {
            return 1/UIScreen.main.scale;
        }
    }
    
    public var jjsSingleLineAdjustOffset: CGFloat! {
        get {
            return self.jjsSingleLineWidth/2;
        }
    }
    
    public func jjs_lineWidthWithPixelNumber(pixelNumber: Int!) -> CGFloat!{
        return CGFloat(pixelNumber) * self.jjsSingleLineWidth;
    }
    
    public func jjs_lineAdjustOffsetWithPixelNumber(pixelNumber: Int!) -> CGFloat! {
        if pixelNumber % 2 == 0 {
            return 0.0;
        } else {
            return self.jjsSingleLineAdjustOffset;
        }
    }
    
    /*
     *所在控制器
     */
    public var jjsViewController: UIViewController! {
        get {
            var view: UIView! = self.superview;
            repeat {
                let responder: UIResponder! = view.next;
                if responder is UIViewController {
                    return responder as! UIViewController!;
                }
                view = view.superview;
            } while (view != nil);
            return nil;
        }
    }
    
    /*
     *visible
     */
    public var jjsIsVisible: Bool! {
        get {
            let viewController: UIViewController?  = self.jjsViewController;
            if viewController == nil {
                return false;
            }
            
            let isVCLoad: Bool! = viewController?.isViewLoaded;
            let haveWindow: Bool = (viewController?.view.window != nil);
            return (isVCLoad && haveWindow);
        }
    }
    
    /*
     *hide keyboard
     */
    public func jjs_hideKeyboard() {
        self.jjs_hideKeyboardOnView(view: self);
    }
    
    public func jjs_hideKeyboardOnView(view: UIView!) {
        for subView in view.subviews {
            if subView is UITextField || subView is UITextView {
                subView .resignFirstResponder();
            } else {
                self.jjs_hideKeyboardOnView(view: subView);
            }
        }
    }
    
    /*
     *Subview
     */
    public var jjsTopView: UIView! {
        get {
            let window: UIWindow! = UIApplication.shared.keyWindow;
            if window.subviews.count > 0 {
                return window.subviews.last;
            } else {
                return window;
            }
        }
    }
    
    public var jjsFirstView: UIView! {
        get {
            let window: UIWindow! = UIApplication.shared.keyWindow;
            if window.subviews.count > 0 {
                return window.subviews.first;
            } else {
                return window;
            }
        }
    }
    
    public func jjs_addSubViews(subViews: [AnyObject]) {
        for obj in subviews {
            self.addSubview(obj);
        }
    }
    
    public func jjs_addSubViews(subViews: [AnyObject], target: Any, action: Selector) {
        for obj in subviews {
            if obj is UIButton {
                (obj as! UIButton).addTarget(target, action: action, for: UIControlEvents.touchUpInside);
            }
            self.addSubview(obj);
        }
    }
}
