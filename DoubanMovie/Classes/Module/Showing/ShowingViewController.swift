//
//  ShowingViewController.swift
//  DoubanMovie
//
//  Created by Heisenbean on 15/8/11.
//  Copyright (c) 2015年 Heisenbean. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

let reuseIdentifier = "cell"
let itemHeight: CGFloat = 187
let itemLeftMargin: CGFloat = 15
let itemMargin: CGFloat = 20
class ShowingViewController: UICollectionViewController {

    @IBOutlet var myCollectionView: UICollectionView!

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
      loadData()
    }
    
    func setupUI(){
    
        
        let itemWidth = (kScreenSize.width - 2 * (itemMargin + itemLeftMargin)) / 3
        layout.itemSize = CGSizeMake(itemWidth,itemHeight)
        myCollectionView.frame.origin = CGPointMake(itemLeftMargin, itemMargin)
        myCollectionView.frame.size.width = kScreenSize.width - 2 * itemLeftMargin
        layout.minimumLineSpacing = 20
        self.myCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 24, 0)
    }
    var jsonArray:[JSON]?
    
    func loadData(){

        let url = "https://api.douban.com/v2/movie/in_theaters"
        Alamofire.request(.GET,url, parameters: nil)
            .responseJSON { (req, res, JsonObj, error) in
                if(error != nil) {
                    NSLog("Error: \(error)")
                    println(req)
                    println(res)
                }
                else {
//                    NSLog("Success: \(url)")
                    var json = JSON(JsonObj!)
                    let movies = json["subjects"].arrayValue
                    self.jsonArray = movies
                    self.collectionView?.reloadData()

                }
        }
    }
    

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return jsonArray?.count ?? 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MovieCell
            cell.hotMovies = jsonArray![indexPath.row]
        return cell
    }
}



class MovieCell:UICollectionViewCell{
    
    @IBOutlet weak var movieImage: UIImageView!

    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var starImageView: UIImageView!
    
    @IBOutlet weak var averageLabel: UILabel!
    
    var hotMovies:JSON?{
        didSet{
            movieName.text = hotMovies!["title"].string
            movieImage.kf_setImageWithURL(NSURL(string: hotMovies!["images"]["large"].string!)!)
            
            let average:Float = hotMovies!["rating"]["average"].floatValue
            if average <= 3.1{
                starImageView.image = UIImage(named: "icon_star_1")
            }else if average > 3.1 && average <= 5.1{
                starImageView.image = UIImage(named: "icon_star_2")
            }else if average > 5.1 && average <= 7.1{
                starImageView.image = UIImage(named: "icon_star_3")
            }else{
                starImageView.image = UIImage(named: "icon_star_4")
            }
            averageLabel.text = hotMovies!["rating"]["average"].stringValue
        }
    }

}
