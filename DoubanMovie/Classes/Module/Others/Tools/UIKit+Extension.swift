//
//  UIKit+Extension.swift
//  DoubanMovie
//
//  Created by Heisenbean on 15/8/11.
//  Copyright (c) 2015年 Heisenbean. All rights reserved.
//

import UIKit

extension UIStoryboard{

    class func initialWithStoryboradName(Sbname name:String) -> UIViewController{
        let sb = UIStoryboard(name: name, bundle: nil)
        return sb.instantiateInitialViewController() as! UIViewController
    }
    
}