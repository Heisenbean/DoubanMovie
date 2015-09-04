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
let itemLeftMargin: CGFloat = 14
let itemMargin: CGFloat = 16
class ShowingViewController: UICollectionViewController {

    @IBOutlet var myCollectionView: UICollectionView!

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    var itemWidth = (kScreenSize.width - 2 * (itemMargin + itemLeftMargin)) / 3

    func setupUI(){
        let itemHeight:CGFloat = itemWidth * 1.7
        layout.itemSize = CGSizeMake(itemWidth,itemHeight)
        myCollectionView.frame.origin = CGPointMake(itemLeftMargin, itemMargin)
        myCollectionView.width = kScreenSize.width - 2 * itemLeftMargin
        layout.minimumLineSpacing = 20
        self.myCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 24, 0)
    }
    var jsonArray:[JSON]?
    
    func loadData(){

        Alamofire.request(.GET,baseUrl + "in_theaters", parameters: nil)
            .responseJSON { (req, res, JsonObj, error) in
                if(error != nil) {
                    NSLog("Error: \(error)")
                    println(req)
                    println(res)
                }
                else {
                    var json = JSON(JsonObj!)
                    let movies = json["subjects"].arrayValue
                    self.jsonArray = movies
                    self.collectionView?.reloadData()
                    println(error,res,req)
                }
        }
    }

}


extension ShowingViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jsonArray?.count ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MovieCell
        cell.hotMovies = jsonArray![indexPath.row]
        return cell
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = UIStoryboard.initialViewController("DetailMovie") as! DetailMovieViewController
        vc.subject_id = jsonArray![indexPath.row]["id"].string
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class MovieCell:UICollectionViewCell{
    
    @IBOutlet weak var movieImage: UIImageView!

    @IBOutlet weak var movieName: UILabel!{
        didSet{
        }
    }
    
    @IBOutlet weak var starImageView: UIImageView!
    
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    var hotMovies:JSON?{
        didSet{

            movieName.text = hotMovies!["title"].string
            movieName.preferredMaxLayoutWidth = 20

            movieImage.kf_setImageWithURL(NSURL(string: hotMovies!["images"]["large"].string!)!)
            
            let average = hotMovies!["rating"]["average"]
            let floatAverage = average.floatValue
            if average <= 3.1{
                starImageView.image = UIImage(named: "icon_star_1")
            }else if average > 3.1 && average <= 5.1{
                starImageView.image = UIImage(named: "icon_star_2")
            }else if average > 5.1 && average <= 7.1{
                starImageView.image = UIImage(named: "icon_star_3")
            }else{
                starImageView.image = UIImage(named: "icon_star_4")
            }
            averageLabel.text = (String.localizedStringWithFormat("%.1f",average.floatValue))
            println(average.floatValue)
            if average.floatValue == 0{
                starImageView.hidden = true
                averageLabel.hidden = true
                tipsLabel.hidden = false
            }else{
                starImageView.hidden = false
                averageLabel.hidden = false
                tipsLabel.hidden = true
            }

        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let itemWidth = (kScreenSize.width - 2 * (itemMargin + itemLeftMargin)) / 3
        if movieName.width >= itemWidth {
            movieName.width = itemWidth
        }

    }
    
}
