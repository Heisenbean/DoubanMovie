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
class DetailMovieView: UIView,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    @IBOutlet weak var movieName: UILabel!{
        didSet{
            movieName.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        }
    }
    
    @IBOutlet weak var movieIcon: UIImageView!
    
    @IBOutlet weak var directorsLabel: UILabel!
    
    @IBOutlet weak var castsLabel: UILabel!{
        didSet{
            castsLabel.preferredMaxLayoutWidth = preferredMaxLayoutWidth
            castsLabel.userInteractionEnabled = true
           let tap = UITapGestureRecognizer(target: self, action: "tapCastLabel:")
            castsLabel.addGestureRecognizer(tap)
        }
    }
    
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
    
    @IBOutlet weak var castCollectionView: UICollectionView!{
        didSet{
//            castCollectionView.backgroundColor = UIColor.whiteColor()
        }
    }
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("---" + "\(self.movies)")
        print("-=-=-" + "\(__FUNCTION__)")
        
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
    
    func tapCastLabel(tap:UITapGestureRecognizer){
        print(tap.numberOfTouches())
    }
    
    @IBAction func test() {
        NSNotificationCenter.defaultCenter().postNotificationName("HEHE", object: nil)
    }
    
    var movies:JSON?{
        didSet{
            
            movieIcon.kf_setImageWithURL(NSURL(string: movies!["images"]["large"].stringValue)!)
            directorsLabel.text = "导演:" + getItemsNameInArray("directors", "name")
            castsLabel.text = "主演:" + getItemsNameInArray("casts", "name")
            typeLabel.text = "类型:" + getItemsNameInArray("genres", nil)
            countryLabel.text = "地区:" + getItemsNameInArray("countries", nil)
            akaLabel.text = "又名:" + getItemsNameInArray("aka", nil)
            summaryLabel.text = movies!["title"].stringValue + "的简介"
            summaryContent.text = movies!["summary"].stringValue
            bgImage.kf_setImageWithURL(NSURL(string: movies!["images"]["large"].stringValue)!)
            var originalTitle = movies!["original_title"].stringValue
            if getItemsNameInArray("countries", nil).hasPrefix("中国大陆"){
                originalTitle = ""
            }
            movieName.text = movies!["title"].stringValue + " " + originalTitle + "(" + movies!["year"].stringValue + ")"
            
            castCollectionView.reloadData()
            print("testtesttesttesttesttesttest")
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        if let movies = movies{
//            return movies["casts"].arrayValue.count
//        }
//
//        
//        return 1
        return movies?["casts"].arrayValue.count ?? 0
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print("" + "\(__FUNCTION__)")
     
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CastCell
        if let movies = movies{
            cell.casts = movies["casts"].arrayValue[indexPath.row]
        }
        return cell
    }
    

    

}

class CastCell:UICollectionViewCell{
    
    var casts:JSON?{
        didSet{
            castName.text = casts!["name"].stringValue
            castImage.kf_setImageWithURL(NSURL(string: casts!["avatars"]["large"].stringValue)!)
        }
    }
    
    @IBOutlet weak var castImage: UIImageView!
    
    @IBOutlet weak var castName: UILabel!

    
}
