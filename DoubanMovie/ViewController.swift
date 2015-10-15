//
//  ViewController.swift
//  DoubanMovie
//
//  Created by Heisenbean on 15/8/11.
//  Copyright (c) 2015年 Heisenbean. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self .addChildsViewController()
    }
    
    
    
    /// 添加子视图控制器
    private func addChildsViewController() {
        addChildViewController("Showing","上映","")
        addChildViewController("Cinema","影院","")
        addChildViewController("MyMovies","我的电影","")
    }

    private func addChildViewController(sbName:String,_ title:String,_ imageName:String) {
        let nav = UIStoryboard.initialViewController(sbName) as! UINavigationController // 添加导航控制器
        nav.topViewController!.title = title  // nav的title
        nav.tabBarItem.image = UIImage(named: imageName)
        nav.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        addChildViewController(nav)
    }

}

