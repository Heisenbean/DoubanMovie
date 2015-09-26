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

class DetailMovieViewController: UIViewController,DetailMovieViewDelegate {
    @IBOutlet weak var mainScrollView: UIScrollView!
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mainScrollView.contentSize = CGSizeMake(0, 800)
    }
    
    var subject_id:String?

    override func viewDidLoad() {
        loadData()
//        (self.view as! DetailMovieView).castCollectionView.registerClass(CastCell.self, forCellWithReuseIdentifier: "cell")
        super.viewDidLoad()
    }
    
    var browserVc = PhotoBrowerViewController()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "test", name: "HEHE", object: nil)
    }

    var tempURL:NSURL?
    
    func test(){
        let vc = UIStoryboard.initialViewController("WebPage") as! WebPageViewController
        vc.webURL = NSURL(string: "http://movie.douban.com/celebrity/1035643/")
//        self.navigationController?.pushViewController(vc, animated: true)
        let navVc = UINavigationController(rootViewController: vc)
        self.presentViewController(navVc, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
                    tempView.removeFromSuperview()
                    let detailView = (self.view as! DetailMovieView)
                    detailView.movies = JSON(result.value!)
                    detailView.imageDelegate = self
                    ProgressHUD.dismiss()
                }
        }
    }
    
    func didSelectCastImage(detailView: DetailMovieView, index: Int) {
        let browserVc = PhotoBrowerViewController.creatBrowserWith(detailView.imageUrls, imageIndex: index)
        presentViewController(browserVc, animated: true, completion: nil)
    }

}
