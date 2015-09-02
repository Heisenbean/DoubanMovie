//
//  Directors.swift
//  DoubanMovie
//
//  Created by Heisenbean on 15/9/2.
//  Copyright (c) 2015年 Heisenbean. All rights reserved.
//

import UIKit

class Person: NSObject {
 /// 影人条目id
    var id: String?
 /// 中文名
    var name: String?
 /// 影人条目URL
    var alt: String?
 /// 影人头像，分别提供420px x 600px(大)，140px x 200px(中) 70px x 100px(小)尺寸
    var avatars: MovieImages?
}
