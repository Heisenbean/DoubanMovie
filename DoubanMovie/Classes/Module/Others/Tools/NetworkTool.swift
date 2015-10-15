//
//  NetworkTool.swift
//  DoubanMovie
//
//  Created by Heisenbean on 15/10/15.
//  Copyright © 2015年 Heisenbean. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class NetworkTool: NSObject {
    /// 网络请求
    /*
    class func requestJSON(method: Alamofire.Method, URLString: String, parameters: [String: AnyObject]? = nil,_ completion:(JSON:AnyObject?)->()){
        Alamofire.request(method,URLString, parameters:parameters).responseJSON() { (_, _, JSON, error)in
            if JSON == nil || error != nil{ // 如果JSON为空或者网络有错误
                dispatch_after(3, dispatch_get_main_queue(), { () -> Void in
                    SVProgressHUD.showWithStatus("网络繁忙,请扫后再试~")
                })
                println("ERROR,JSON:\(JSON),error:\(error)")
                completion(JSON: nil)
                return
            }
            completion(JSON: JSON)
        }
    }
    */
    
    
    class func requestJSON(method: Alamofire.Method, URLString: String, parameters:[String: AnyObject]? = nil,_ completion:(JSONData:AnyObject?)->()){
        Alamofire.request(method, URLString, parameters: parameters).responseJSON { (request, response, result) -> Void in
            if(result.isFailure) {
                ProgressHUD.showError("网络错误,请稍后再试")
                print("Error: \(result.error)\(request)\(response)")
                completion(JSONData: nil)
            }
            completion(JSONData: result.value)
            ProgressHUD.dismiss()
        }
    }
    
}
