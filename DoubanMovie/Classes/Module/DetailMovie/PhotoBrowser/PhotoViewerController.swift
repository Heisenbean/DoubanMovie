//
//  PhotoViewerController.swift
//  swiftQuan
//
//  Created by DLonion on 15/7/29.
//  Copyright (c) 2015年 DLonion. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD
class PhotoViewerController: UIViewController, UIScrollViewDelegate {
    
    var dummyView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
        }
    }
    
    var scale: CGFloat = 1
    
    var topInset: CGFloat = 0
    
    var isLoadingImage: Bool = false
    
    var imageURL: NSURL? {
        didSet {
            
            //重置UI
            imageView.image = nil
            scrollView.zoomScale = 1
            scrollView.contentSize = CGSizeZero
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            scrollView.contentOffset = CGPointZero
            let downloader = KingfisherManager.sharedManager.downloader
            downloader.downloadTimeout = 3.0
            downloader.downloadImageWithURL(imageURL!, progressBlock: { (receivedSize, totalSize) -> () in
                if !self.isLoadingImage {
                    SVProgressHUD.show()
                    self.isLoadingImage = true
                }
                
                }) { (image, error, imageURL, originalData) -> () in
                    self.isLoadingImage = false
                    SVProgressHUD.dismiss()
                    if error != nil {
                        SVProgressHUD.showInfoWithStatus("加载图片错误")
                        return
                    }
                    self.calaImageSize(image!)       
            }
        }
    }
    
    lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.userInteractionEnabled = true
        
        return imageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.view.bounds)

        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
        
        scrollView.delegate = self
        
        return scrollView
    }()
    
    // MARK: -  scrollView的代理
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        if imageView.transform.a < 1 {
            scale
             = imageView.transform.a
            startInteractiveTransition(self)
        }
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        
        if scale < 1 {
            completeTransition(true)
            return
            
        }else {
            view!.alpha = 1
        }
        
        let top = (scrollView.height - view!.height) * 0.5
        
        if top > 0 {
            scrollView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0)
        } else {
            // top < 0 说明图片放大的结果，已经超出了 scrollView
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        
        
    }
    
    // MARK: - 生命周期
    override func loadView() {

        view = UIView(frame: UIScreen.mainScreen().bounds)
        
        view.backgroundColor = UIColor.blackColor()
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        setupGesture()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    // MARK: - 设置手势
    private func setupGesture() {
        
        
        let tap = UITapGestureRecognizer(target: self, action: "tap")
        scrollView.addGestureRecognizer(tap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: "doubleTap")
        doubleTap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTap)
        
        //没有双击才触发单击
        tap.requireGestureRecognizerToFail(doubleTap)
    }
    
    func doubleTap() {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            if self.scrollView.zoomScale > 1 {

                self.scrollView.zoomScale = 1
                self.scrollView.contentInset = UIEdgeInsetsMake(self.topInset, 0, 0, 0)
            }else {

                self.scrollView.zoomScale = 2
                
                //计算图片2倍大小时的topInset
                let top = (self.view.height - (self.view.height - self.topInset * 2) * 2) * 0.5
                if top > 0 {
                    self.scrollView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0)
                }else {
                    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
                }
            }
        })
    }
    
    func tap() {

        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: - 计算图片大小
    func calaImageSize(image: UIImage) {
        
        let size = scaleImageSize(image)
        
        imageView.frame = CGRectMake(0, 0, size.width, size.height)
        imageView.image = image
        
        if size.height >= view.height {
            
            scrollView.contentSize = size
            
        }else {
            topInset = (view.height - size.height) * 0.5
            scrollView.contentInset = UIEdgeInsetsMake(topInset, 0, 0, 0)
        }
        
    }
    
    func scaleImageSize(image: UIImage) -> CGSize {
        let scale = image.size.width / view.width
        let h = image.size.height / scale
        
        return CGSizeMake(view.width, h)
    }
    


}

// MARK: - 交互式转场协议
///交互式转场协议
extension PhotoViewerController: UIViewControllerInteractiveTransitioning {
    
    ///调用此方法开始进行转场, 需要提供一个遵守了UIViewControllerContextTransitioning协议的对象
    //UIViewControllerContextTransitioning 提供了转场的具体信息
    func startInteractiveTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let toView = toVc!.view
        dummyView = toView.snapshotViewAfterScreenUpdates(false)
        
        transitionContext.containerView()!.insertSubview(dummyView!, belowSubview: view)
        
        view.alpha = scale
        
    }
}


// MARK: - 转场上下文协议
///转场上下文协议
extension PhotoViewerController: UIViewControllerContextTransitioning {
    
    //提供转场的容器,
    func containerView() -> UIView? {
        return view.superview!
    }
    
    //转场结束
    func completeTransition(didComplete: Bool){
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    //提供转场的相关控制器
    func viewControllerForKey(key: String) -> UIViewController? {
        
        if key == UITransitionContextToViewControllerKey {
            return UIApplication.sharedApplication().keyWindow?.rootViewController
        }else if key == UITransitionContextFromViewControllerKey {
            return self
        }
        
        return nil
    }
    

    @available(iOS, introduced=8.0)
    func viewForKey(key: String) -> UIView? {
        return nil
    }
    
    @available(iOS, introduced=8.0)
    func targetTransform() -> CGAffineTransform {
        return CGAffineTransformIdentity
    }
    

    func initialFrameForViewController(vc: UIViewController) -> CGRect {
        return CGRectZero
    }
    func finalFrameForViewController(vc: UIViewController) -> CGRect {
        return CGRectZero
    }
    

    func isAnimated() -> Bool {
        return true
    }
    
    func isInteractive() -> Bool {
        return true
    }
    
    func transitionWasCancelled() -> Bool {
        return false
    }
    
    func presentationStyle() -> UIModalPresentationStyle {
        return UIModalPresentationStyle.Custom
    }
    

    func updateInteractiveTransition(percentComplete: CGFloat) {
        
    }
    func finishInteractiveTransition() {
        
    }
    func cancelInteractiveTransition() {
        
    }
    
}












