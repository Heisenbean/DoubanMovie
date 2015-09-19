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

    override func viewDidLoad() {
        loadData()
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        ProgressHUD.dismiss()
    }
    
    func loadData(){
        let tempView = UIView(frame: self.view.frame)
        tempView.backgroundColor = UIColor.colorFromRGB(0xf0f0f0, alpha: 1.0)
        view.addSubview(tempView)
        ProgressHUD.show("加载中,请稍后...")
        Alamofire.request(.GET,baseUrl + "subject/\(subject_id!)", parameters: nil)
            .responseJSON { (request, respons, result) in
                if(result.isFailure) {
                    NSLog("Error: \(result.error)")
                    print(request)
                    print(respons)
                    ProgressHUD.showError("网络错误,请稍后再试")
                }
                else {
//                    print(result)
                    tempView.removeFromSuperview()
                    (self.view as! DetailMovieView).movies = JSON(result.value!)
                    ProgressHUD.dismiss()
                }
        }
        

    }

}
