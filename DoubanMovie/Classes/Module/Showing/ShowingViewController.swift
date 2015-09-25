//
//  ShowingViewController.swift
//  DoubanMovie
//
//  Created by Heisenbean on 15/8/11.
//  Copyright (c) 2015年 Heisenbean. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import Kingfisher

let reuseIdentifier = "cell"
let itemLeftMargin: CGFloat = 14
let itemMargin: CGFloat = 16
class ShowingViewController: UICollectionViewController {

    @IBOutlet var myCollectionView: UICollectionView!

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    var canceld = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    var itemWidth = (kScreenSize.width - 2 * (itemMargin + itemLeftMargin)) / 3

    func setupUI(){
        view.backgroundColor = UIColor.colorFromRGB(0xf0f0f0, alpha: 1.0)
        let itemHeight:CGFloat = itemWidth * 1.7
        layout.itemSize = CGSizeMake(itemWidth,itemHeight)
        myCollectionView.frame.origin = CGPointMake(itemLeftMargin, itemMargin)
        myCollectionView.width = kScreenSize.width - 2 * itemLeftMargin
        layout.minimumLineSpacing = 20
        self.myCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 24, 0)

    }
    var jsonArray:[JSON]?
    
    func loadData(){
        ProgressHUD.show("加载中,请稍后....")
        Alamofire.request(.GET, baseUrl + "in_theaters", parameters: nil)
        .responseJSON { (req, res, result) -> Void in
            if(result.isFailure) {
                ProgressHUD.showError("网络错误,请稍后再试")
                print("Error: \(result.error)\(req)\(res)")
            }
            else {
                ProgressHUD.dismiss()
                var json = JSON(result.value!)
                let movies = json["subjects"].arrayValue
                self.jsonArray = movies
                    self.collectionView?.reloadData()
            }
        }
    }
}


extension ShowingViewController{
    
    
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

    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var starImageView: UIImageView!
    
    @IBOutlet weak var averageLabel: UILabel!
    
    @IBOutlet weak var tipsLabel: UILabel!
    var hotMovies:JSON?{
        didSet{

            movieName.text = hotMovies!["title"].string
            movieName.preferredMaxLayoutWidth = 20

            movieImage.kf_setImageWithURL(NSURL(string: hotMovies!["images"]["large"].string!)!)
            
            let average = hotMovies!["rating"]["average"]
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
