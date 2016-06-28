//
//  ViewController.swift
//  MusicVideo
//
//  Created by KwokWing Tong on 25/6/2016.
//  Copyright © 2016 Tong Kwok Wing. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
  var videos = [Videos]()

  @IBOutlet weak var displatLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    //Call API
    let api = APIManager()
    
    api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
    
    // When "ReachStatusChanged" in Push Notification method is changed , then will call the function reachabilityStatusChanged
    
    reachabilityStatusChanged()
    
    tableView.dataSource = self
    tableView.delegate = self
  }

  func reachabilityStatusChanged(){
    switch reachabilityStatus {
    case NOACCESS : view.backgroundColor = UIColor.redColor()
    displatLabel.text = "No Internet"
    case WIFI : view.backgroundColor = UIColor.greenColor()
    displatLabel.text = "Reachable with WIFI"
    case WWAN : view.backgroundColor = UIColor.yellowColor()
    displatLabel.text = "Reachable with Cellular"
    default:return
    }
  }
  
  // Is called just as the object is about to be deallocated
  deinit
  {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
  }
  
  
  func didLoadData(videos: [Videos]){
    
    print(reachabilityStatus)
    
    self.videos = videos // put the parameter videos into our variable videos
    
    for item in videos {
      print("name = \(item.vName)")
    }
    
    // if you want to have a index value of the array, you should do this way
    for (index, item) in videos.enumerate() {
      print("\(index) name = \(item.vName)")
    }
    
    
    tableView.reloadData()
    
    //        for i in 0..<videos.count {
    //            let video = videos[i]
    //            print("\(i) name = \(video.vName)")
    //        }
    
    //        for var i = 0; i < videos.count; i++ {
    //            let video = videos[i]
    //            print("\(i) name = \(video.vName)")
    //        }
    
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return videos.count
    
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("cell",forIndexPath: indexPath)
    
    let video = videos[indexPath.row]
    
    cell.textLabel?.text = ("\(indexPath.row + 1)")
    
    cell.detailTextLabel?.text = video.vName
    
    return cell
    
    
  }
}

