//
//  Movies.swift
//  DoubanMovie
//
//  Created by Heisenbean on 15/8/12.
//  Copyright (c) 2015年 Heisenbean. All rights reserved.
//

import UIKit

class Movies: NSObject {
    /// 评级
    var rating:Rate?
    /// 种类
    var genres: [AnyObject]?

    var collect_count: Int = 0
    /// 演员
    var casts: [AnyObject]?
    /// 图片
    var images: MovieImages?
    /// 中文名
    var title: String?
    /// 原名
    var original_title: String?
    /// 类型
    var subtype: String = "movie"
    /// 导演
    var directors: [AnyObject]?
    
    var year:String?
    
    /// 条目URL
    var alt: String?
    
    var id: String?
    
    
}
