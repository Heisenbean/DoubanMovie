//
//  UIExtension.swift
//  DoubanMovie
//
//  Created by Heisenbean on 15/8/31.
//  Copyright (c) 2015年 Heisenbean. All rights reserved.
//

import UIKit

extension UIView {
    
    var x : CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newX) {
            self.frame.origin.x = newX
        }
    }
    
    var y : CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newY) {
            self.frame.origin.y = newY
        }
    }
    
    var width : CGFloat {
        get {
            return self.frame.size.width
        }
        set(newWidth) {
            self.frame.size.width = newWidth
        }
    }
    
    var height : CGFloat {
        get {
            return self.frame.size.height
        }
        set(newHeight) {
            self.frame.size.height = newHeight
        }
    }
}

extension CGRect {
    var x : CGFloat {
        get {
            return self.origin.x
        }
        set(newX) {
            self.origin.x = newX
        }
    }
    
    var y : CGFloat {
        get {
            return self.origin.y
        }
        set(newY) {
            self.origin.y = newY
        }
    }
    
    var width : CGFloat {
        get {
            return self.size.width
        }
        set(newWidth) {
            self.size.width = newWidth
        }
    }
    
    var height : CGFloat {
        get {
            return self.size.height
        }
        set(newHeight) {
            self.size.height = newHeight
        }
    }
    
    
}

extension UIStoryboard {
    
    class func initialViewController(name: String) -> UIViewController {
        let sb = UIStoryboard(name: name, bundle: nil)
        return sb.instantiateInitialViewController()!
    }
}


extension UIColor {
    
    
    class func colorFromRGB(rgbValue: Int, alpha: CGFloat) -> UIColor {
        
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(rgbValue & 0xFF))/255.0, alpha: alpha)
    }

//    class func colorFromRGB(rgbValue: UInt) -> UIColor {
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }
    
    class func randomColor() -> UIColor {
        
        return UIColor(red: CGFloat(arc4random_uniform(256)) / 255, green: CGFloat(arc4random_uniform(256)) / 255, blue: CGFloat(arc4random_uniform(256)) / 255, alpha: 1.0)
    }
}

extension UIBarButtonItem {
    
    class func itemWith(bg: String, highBg: String, target: AnyObject, imageInset: UIEdgeInsets, action: Selector) -> UIBarButtonItem {
        
        let button = UIButton()
        
        button.setImage(UIImage(named: bg), forState: UIControlState.Normal)
        button.setImage(UIImage(named: highBg), forState: UIControlState.Highlighted)
        button.imageEdgeInsets = imageInset
        button.sizeToFit()
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        return UIBarButtonItem(customView: button)
    }
}

extension UIScreen {
    
    class func isInch3_5() -> Bool {
        
        
        return UIScreen.mainScreen().bounds.height == 480 ? true : false
    }
    
    class func isInch4_0() -> Bool {
        
        
        return UIScreen.mainScreen().bounds.height == 568 ? true : false
    }
    
    class func isInch4_7() -> Bool {
        
        
        return UIScreen.mainScreen().bounds.height == 667 ? true : false
    }
    
    class func isInch5_5() -> Bool {
        
        
        return UIScreen.mainScreen().bounds.height == 736 ? true : false
    }
}

extension UITableView {
    
    func registerCellFromXibWithName(name: String) {
        
        let nib = UINib(nibName: name, bundle: nil)
        
        self.registerNib(nib, forCellReuseIdentifier: name)
    }
    
}


extension NSDate{
    
    class func getMyDataFormat(dateString:String,_ dataFormatter:String) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:ss"
        let dateStr = dateFormatter.dateFromString(dateString)
        let dateFormatter1 = NSDateFormatter()
        dateFormatter1.dateFormat = dataFormatter
        return dateFormatter1.stringFromDate(dateStr!)
    }
}
