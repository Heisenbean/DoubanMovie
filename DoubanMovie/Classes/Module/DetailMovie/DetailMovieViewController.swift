//
//  DetailMovieViewController.swift
//  DoubanMovie
//
//  Created by Heisenbean on 15/8/24.
//  Copyright (c) 2015年 Heisenbean. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailMovieViewController: UIViewController {
    @IBOutlet weak var mainScrollView: UIScrollView!
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mainScrollView.contentSize = CGSizeMake(0, 800)
    }
    
    var subject_id:String?

    var movies:JSON?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println(__FUNCTION__)
        loadData()
    }
    
    override func viewDidAppear(animated: Bool) {
                println(__FUNCTION__)
    }
    

    override func viewDidLoad() {
        println(__FUNCTION__)
        super.viewDidLoad()
    }
    
    func loadData(){
//        println(baseUrl + "subject/\(subject_id!)")
        
        
        Alamofire.request(.GET,baseUrl + "subject/\(subject_id!)", parameters: nil)
            .responseJSON { (req, res, JsonObj, error) in
                if(error != nil) {
                    NSLog("Error: \(error)")
                    println(req)
                    println(res)
                }
                else {
                    (self.view as! DetailMovieView).movies = JSON(JsonObj!)
//                    movieView.movies = JSON(JsonObj!)
//                    self.movieName.text = self.movies!["title"].stringValue
//                    let movies = json["summary"].string
//                    println("===\(movies)")

                    
                }
        }

    }

}
