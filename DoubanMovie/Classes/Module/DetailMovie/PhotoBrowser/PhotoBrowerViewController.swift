//
//  PhotoBrowerViewController.swift
//  swiftQuan
//
//  Created by DLonion on 15/7/28.
//  Copyright (c) 2015年 DLonion. All rights reserved.
//

import UIKit

private let cellIdentifier = "PhotoCellIdentifier"

class PhotoBrowerViewController: UIViewController{
    
    private var imageURLs: [NSURL]?
    private var imageIndex: Int = 0
    
    class func creatBrowserWith(imageURLs: [NSURL], imageIndex: Int) -> PhotoBrowerViewController {
        
        let browser = PhotoBrowerViewController()
        browser.imageURLs = imageURLs
        browser.imageIndex = imageIndex
        
        return browser
    }
    
    
    lazy var layout: UICollectionViewFlowLayout = {
        
        let l = UICollectionViewFlowLayout()
        
        l.itemSize = self.view.bounds.size
        l.minimumInteritemSpacing = 0
        l.minimumLineSpacing = 0
        l.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        return l
        
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.layout)
        
        cv.delegate = self
        cv.dataSource = self
        cv.pagingEnabled = true
        
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        
        let imageCount = self.imageURLs?.count ?? 0
        let pageControl = UIPageControl()
        
        pageControl.numberOfPages = imageCount
        pageControl.currentPage =  self.imageIndex
        
        pageControl.frame = CGRectMake(0, 0, pageControl.sizeForNumberOfPages(imageCount).width, pageControl.sizeForNumberOfPages(imageCount).height)
        pageControl.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.9)
        return pageControl
    }()
    
    
    override func loadView() {
        view = UIView(frame: UIScreen.mainScreen().bounds)
        
        view.addSubview(collectionView)
        
        view.addSubview(pageControl)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerClass(PhotoBrowserCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        let indexPath = NSIndexPath(forItem: imageIndex, inSection: 0)

        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: [], animated: true)
        
        print(imageURLs)
    }
    

    
    func rndColor() -> CGFloat {
        return CGFloat(arc4random_uniform(256)) / 255
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        dismissViewControllerAnimated(true, completion: nil)
    }

}

extension PhotoBrowerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! PhotoBrowserCell
        
        cell.imageURL = imageURLs![indexPath.item]
        cell.backgroundColor = UIColor(red: rndColor(), green: rndColor(), blue: rndColor(), alpha: 1)
        
        //多控制器镶套的时候一定要记得添加childViewController 否则响应者链条会断裂 导致与控制器相关的方法没有响应   比如 dismissController方法
        if !(childViewControllers as NSArray).containsObject(cell.viewerVc!) {
            addChildViewController(cell.viewerVc!)
        }
        
        return cell
    }
    
    // MARK: - delegate
    
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        
        let path = collectionView.indexPathsForVisibleItems().last
        pageControl.currentPage = path!.item

        
    }
    

}


class PhotoBrowserCell: UICollectionViewCell {
    
    var viewerVc: PhotoViewerController?
    var imageURL: NSURL? {
        didSet {
            viewerVc?.imageURL = imageURL
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewerVc = PhotoViewerController()
        viewerVc?.view.frame = bounds
        
        addSubview(viewerVc!.view)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}









