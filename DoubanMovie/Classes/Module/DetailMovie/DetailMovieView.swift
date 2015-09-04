//
//  DetailMovieView.swift
//  DoubanMovie
//
//  Created by Heisenbean on 15/9/2.
//  Copyright (c) 2015年 Heisenbean. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailMovieView: UIView {

    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var movieIcon: UIImageView!
    
    @IBOutlet weak var directorsLabel: UILabel!
    
    @IBOutlet weak var castsLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var akaLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var summaryContent: UILabel!{
        didSet{
            summaryContent.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 8
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        summaryContent.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 8
        self.layoutIfNeeded()
    }
   

    
    var movies:JSON?{
        didSet{
            
            movieIcon.kf_setImageWithURL(NSURL(string: movies!["images"]["large"].stringValue)!)
            var directorsArray = [String]()
            var castsArray = [String]()
            var genresArray = [String]()
            var countryArray = [String]()
            var akaArray = [String]()


            for d in movies!["directors"].arrayValue{
                directorsArray.append(d["name"].stringValue)
            }
            directorsLabel.text = "导演:" + ",".join(directorsArray)
            
            for d in movies!["casts"].arrayValue{
                castsArray.append(d["name"].stringValue)
            }
            castsLabel.text = "主演:" + ",".join(castsArray)
            
            for d in movies!["genres"].arrayValue{
                genresArray.append(d.stringValue)
            }
            typeLabel.text = "类型:" + ",".join(genresArray)

            for d in movies!["countries"].arrayValue{
                countryArray.append(d.stringValue)
            }
            countryLabel.text = "地区:" + ",".join(countryArray)
            for d in movies!["countries"].arrayValue{
                countryArray.append(d.stringValue)
            }
            countryLabel.text = "地区:" + ",".join(countryArray)
            
            for d in movies!["aka"].arrayValue{
                akaArray.append(d.stringValue)
            }
            akaLabel.text = "又名:" + ",".join(akaArray)

            summaryLabel.text = movies!["title"].stringValue + "的简介"
            
            summaryContent.text = movies!["summary"].stringValue
            var originalTitle = movies!["original_title"].stringValue
            
            if ",".join(countryArray).hasPrefix("中国大陆"){
                originalTitle = ""
            }
            
            movieName.text = movies!["title"].stringValue + originalTitle + "(" + movies!["year"].stringValue + ")"

        }
        
    }
    

}
