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
let reuseIdentifier = "cell"

class ShowingViewController: UICollectionViewController {


    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.collectionView!.registerClass(MovieCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        
      
    }
    
    override func viewWillAppear(animated: Bool) {
        loadData()

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
            cell.movieName.text = s
            cell.movieName.sizeToFit()
//            cell.movieName.textAlignment = .Center
            println(s)
    }
        
        return cell
    }
}



class MovieCell:UICollectionViewCell{

    @IBOutlet weak var movieImage: UIImageView!

    @IBOutlet weak var movieName: UILabel!
}
