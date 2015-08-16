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
let itemHeight: CGFloat = 200
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
        
        layout.minimumLineSpacing = 25
//        layout.minimumInteritemSpacing = 20
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
//                    println(movies[0]["title"])
                    self.collectionView?.reloadData()

                }
        }
    }
    

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 10
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MovieCell
        if (jsonArray != nil){
            let s = jsonArray![indexPath.row]["title"].string!
            let imageStr = jsonArray![indexPath.row]["images"]["large"].string!
            let imageUrl = NSURL(string: imageStr)
            cell.movieName.text = s
            cell.movieImage.kf_setImageWithURL(imageUrl!)
    }
        
        return cell
    }
}



class MovieCell:UICollectionViewCell{

    @IBOutlet weak var movieImage: UIImageView!

    @IBOutlet weak var movieName: UILabel!
}
