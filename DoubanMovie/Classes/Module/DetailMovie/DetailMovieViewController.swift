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
    
    // MARK: 属性声明
    @IBOutlet weak var mainScrollView: UIScrollView!
    

    var subject_id:String?
    
    var urlArray = [NSURL]()


    
    
    // MARK: 视图声明周期
    override func viewDidLoad() {
        loadData()
        //        (self.view as! DetailMovieView).castCollectionView.registerClass(CastCell.self, forCellWithReuseIdentifier: "cell")
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //      NSNotificationCenter.defaultCenter().addObserverForName("aa", object: nil, queue: nil) { (userInfo) -> Void in
        //            print(userInfo.valueForKey("userInfo"))
        //        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didClickedMovieIcon", name:ClickedImageNotification, object: nil)
    }

    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
        ProgressHUD.dismiss()
    }
    
    func didClickedMovieIcon(){
        let browser = PhotoBrowerViewController.creatBrowserWith(urlArray, imageIndex: 0)
        presentViewController(browser, animated: true, completion: nil)
    }
    
    // MARK: 功能相关
    
    func test(){
        let vc = UIStoryboard.initialViewController("WebPage") as! WebPageViewController
        vc.webURL = NSURL(string: "http://movie.douban.com/celebrity/1035643/")
        //        self.navigationController?.pushViewController(vc, animated: true)
        let navVc = UINavigationController(rootViewController: vc)
        self.presentViewController(navVc, animated: true, completion: nil)
    }
    
    
    // MARK:加载数据
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
                    self.urlArray.append(NSURL(string: JSON(result.value!)["images"]["large"].stringValue)!)
                    detailView.movies = JSON(result.value!)
                    detailView.imageDelegate = self
                    detailView.scrollView = self.mainScrollView
                    ProgressHUD.dismiss()
                }
        }
    }
    
    func didSelectCastImage(detailView: DetailMovieView, index: Int) {
        let browserVc = PhotoBrowerViewController.creatBrowserWith(detailView.imageUrls, imageIndex: index)
        presentViewController(browserVc, animated: true, completion: nil)
    }

}
