//
//  AppDelegate.swift
//  DoubanMovie
//
//  Created by Heisenbean on 15/8/11.
//  Copyright (c) 2015年 Heisenbean. All rights reserved.
//

import UIKit
let kScreenSize = UIScreen.mainScreen().bounds.size
let baseUrl = "https://api.douban.com/v2/movie/"
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        
        self.window?.rootViewController = UIStoryboard.initialWithStoryboradName(Sbname: "Main")
        
        return true
    }

}

