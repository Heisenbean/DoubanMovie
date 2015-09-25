//
//  WebPageViewController.swift
//  DoubanMovie
//
//  Created by Heisenbean on 15/9/25.
//  Copyright © 2015年 Heisenbean. All rights reserved.
//

import UIKit

class WebPageViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!{
        didSet{
            webView.delegate = self
        }
    }
    
    var webURL:NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let webURL = webURL{
        webView.loadRequest(NSURLRequest(URL: webURL))
        }
    }

    
    
}
