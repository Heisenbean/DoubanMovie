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
    /// 图片
    /*
    电影海报图，分别提供288px x 465px(大)，96px x 155px(中) 64px x 103px(小)尺寸
    */
    var images: MovieImages?
    /// 中文名
    var title: String?
    /// 原名
    var original_title: String?
    /// 又名
    var aka:[String]?
    /// 条目页URL
    var alt:String?
    /// 移动版条目页URL
    var mobile_url:String?
    /// 评分人数
    var ratings_count:Int = 0
    /// 想看人数
    var wish_count:Int = 0
    /// 看过的人数
    var collect_count:Int = 0
    /// 正在看的人数
    var do_count:Int = 0
    /// 类型
    var subtype: String = "movie"
    /// 导演
    var directors: [Person]?
    /// 演员
    var casts:[Person]?
    /// 豆瓣小站
    var douban_site:String?
    /// 年代
    var year:String?
    /// 制片国家/地区
    var countries:[String]?
    /// 短评数
    var comments_count:Int = 0
    /// 影评数
    var reviews_count:Int = 0
    /// 总季数(tv only)
    var seasons_count:Int = 0
    /// 当前季数(tv only)
    var current_season:Int = 0
    /// 当前季的集数(tv only)
    var episodes_coun:Int = 0
    /// 影讯页URL(movie only)
    var schedule_url:String?
    /// 简介
    var summary:String?
    /// 条目id
    var id: String?
    
    
}
