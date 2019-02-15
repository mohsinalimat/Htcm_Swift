//
//  UIView+SSAdd.swift
//  htcm_swift
//
//  Created by soldoros on 2018/12/20.
//  Copyright © 2018年 soldoros. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    //获取当前视图的控制器
    public func viewController()->UIViewController? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }

    
    
    public var left: CGFloat{
        get{
            return self.frame.origin.x;
        }
        set{
            var frame = self.frame;
            frame.origin.x = newValue;
            self.frame = frame;
        }
    }
    
    public var top: CGFloat{
        get{
            return self.frame.origin.y;
        }
        set{
            var frame = self.frame;
            frame.origin.y = newValue;
            self.frame = frame;
        }
    }
    
    public var right: CGFloat{
        get{
            return self.frame.origin.x + self.frame.size.width;
        }
        set{
            var frame = self.frame;
            frame.origin.x = newValue - frame.size.width;
            self.frame = frame;
        }
    }
    
    public var bottom: CGFloat{
        get{
            return self.frame.origin.y + self.frame.size.height;
        }
        set{
            var frame = self.frame;
            frame.origin.y = newValue - frame.size.height;
            self.frame = frame;
        }
    }
    
    
    public var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    
    public var height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    
    public var centerX : CGFloat{
        get{
            return self.center.x
        }
        set{
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    public var centerY : CGFloat{
        get{
            return self.center.y
        }
        set{
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    
    
    public var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            var frame = self.frame;
            frame.origin = newValue;
            self.frame = frame;
        }
    }
    
    public var size: CGSize{
        get{
            return self.frame.size
        }
        set{
            var frame = self.frame;
            frame.size = newValue;
            self.frame = frame;
        }
    }
    
    
    //出场动画
    public func animateIn()->(){
        self.transform =  CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { (true) in
            
            UIView.animate(withDuration: 1/15, animations: {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { (true) in
                UIView.animate(withDuration: 1/7.5, animations: {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: { (true) in
                    
                })
            })
        })
        
    }
    
    //回收动画
    public func animateOut()->(){
        
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { (true) in
            
            UIView.animate(withDuration: 1/15, animations: {
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: { (true) in
                UIView.animate(withDuration: 1/7.5, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                }, completion: { (true) in
                    self.removeFromSuperview()
                })
            })
        })
        
    }
    
}
