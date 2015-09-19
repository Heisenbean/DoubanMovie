//
//  DetailMovieView.swift
//  DoubanMovie
//
//  Created by Heisenbean on 15/9/2.
//  Copyright (c) 2015年 Heisenbean. All rights reserved.
//

import UIKit
import SwiftyJSON
let preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 16
class DetailMovieView: UIView {

    @IBOutlet weak var movieName: UILabel!{
        didSet{
            movieName.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        }
    }
    
    @IBOutlet weak var movieIcon: UIImageView!
    
    @IBOutlet weak var directorsLabel: UILabel!
    
    @IBOutlet weak var castsLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var akaLabel: UILabel!{
        didSet{
            akaLabel.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        }
    }

    
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var summaryContent: UILabel!{
        didSet{
            summaryContent.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        }
    }
    
    @IBOutlet weak var bgImage: UIImageView!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        summaryContent.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 12
        self.layoutIfNeeded()
        print(summaryContent.frame)
        print(UIScreen.mainScreen().bounds.width)
    }
   

    
    func getItemsNameInArray(itemsName:String,_ name:String?) ->String{
        var tempArray = [String]()
        for i in movies![itemsName].arrayValue{
            if name == nil{
                tempArray.append(i.stringValue)
            }else{
                tempArray.append(i[name!].stringValue)
            }
        }
        return tempArray.joinWithSeparator(",")
    }
    
    
    var movies:JSON?{
        didSet{
            
            movieIcon.kf_setImageWithURL(NSURL(string: movies!["images"]["large"].stringValue)!)
            let countryArray = [String]()
            directorsLabel.text = "导演:" + getItemsNameInArray("directors", "name")
            castsLabel.text = "主演:" + getItemsNameInArray("casts", "name")
            typeLabel.text = "类型:" + getItemsNameInArray("genres", nil)
            countryLabel.text = "地区:" + getItemsNameInArray("countries", nil)
            akaLabel.text = "又名:" + getItemsNameInArray("aka", nil)
            summaryLabel.text = movies!["title"].stringValue + "的简介"
            summaryContent.text = movies!["summary"].stringValue
            bgImage.kf_setImageWithURL(NSURL(string: movies!["images"]["large"].stringValue)!)
            var originalTitle = movies!["original_title"].stringValue
            if countryArray.joinWithSeparator(",").hasPrefix("中国大陆"){
                originalTitle = ""
            }
            movieName.text = movies!["title"].stringValue + originalTitle + "(" + movies!["year"].stringValue + ")"
        }
        
    }
    

}
