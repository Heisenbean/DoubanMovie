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

class DetailMovieViewController: UITableViewController {

    var subject_id:String?{
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()
        loadData()
    }
    
    func loadData(){
        println(baseUrl + "subject/\(subject_id!)")
        Alamofire.request(.GET,baseUrl + "subject/\(subject_id!)", parameters: nil)
            .responseJSON { (req, res, JsonObj, error) in
                if(error != nil) {
                    NSLog("Error: \(error)")
                    println(req)
                    println(res)
                }
                else {
                    var json = JSON(JsonObj!)
                    let movies = json["summary"].string
                    self.tableView?.reloadData()
                    println("===\(movies)")
                    
                }
        }

    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell


        return cell
    }




}
