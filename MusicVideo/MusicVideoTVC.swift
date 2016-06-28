//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by KwokWing Tong on 28/6/2016.
//  Copyright © 2016 Tong Kwok Wing. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

  var videos = [Videos]()
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    //Call API
    let api = APIManager()
    
    api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
    
    // When "ReachStatusChanged" in Push Notification method is changed , then will call the function reachabilityStatusChanged
    
    reachabilityStatusChanged()
    
  
  }
  
  func reachabilityStatusChanged(){
    switch reachabilityStatus {
    case NOACCESS : view.backgroundColor = UIColor.redColor()
    //displatLabel.text = "No Internet"
    case WIFI : view.backgroundColor = UIColor.greenColor()
    //displatLabel.text = "Reachable with WIFI"
    case WWAN : view.backgroundColor = UIColor.yellowColor()
    //displatLabel.text = "Reachable with Cellular"
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
      let video = videos[indexPath.row]
      
      cell.textLabel?.text = ("\(indexPath.row + 1)")
      
      cell.detailTextLabel?.text = video.vName

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
