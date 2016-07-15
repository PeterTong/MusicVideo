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
	
	var filterSearch = [Videos]()
	
	let resultSearchController = UISearchController(searchResultsController: nil)
	
	
	var limit = 10
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		
		
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
		
		// When "ReachStatusChanged" in Push Notification method is changed , then will call the function reachabilityStatusChanged
		
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(preferredFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)// This is a way to viewcontroller for observer font size changed
		
		reachabilityStatusChanged()
		
  
	}
	
	func preferredFontChange(){
		
		print("The preferred font is changed")
	}
	
	func reachabilityStatusChanged(){
		switch reachabilityStatus {
		case NOACCESS :
			//view.backgroundColor = UIColor.redColor()
			// move back to Main Queue
			// if not do that, it will pop up a warning said "Presenting View controllers on detached view controllers is discouraged
			dispatch_async(dispatch_get_main_queue()) {
				let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .Alert)
				
				let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
					action -> () in
					print("Cancel")
				}
				
				let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
					action -> () in
					print("delete")
				}
				let okAction = UIAlertAction(title: "ok", style: .Default) { action -> Void in
					print("Ok")
					
					//do something if you want
					//alert.dismissViewControllerAnimated(true, completion: nil)
				}
				
				alert.addAction(okAction)
				alert.addAction(cancelAction)
				alert.addAction(deleteAction)
				
				
				self.presentViewController(alert, animated: true, completion: nil)
			}
		default:
			//view.backgroundColor = UIColor.greenColor()
			// To make sure run the API one time ,to make the code more smart
			if videos.count > 0 {
				print("do not refresh API")
			} else {
				runAPI()
				
			}
			
		}
	}
	
	
	@IBAction func refresh(sender: UIRefreshControl) {
		
		refreshControl?.endRefreshing()
		
		if resultSearchController.active{
			refreshControl?.attributedTitle = NSAttributedString(string: "No refresh allowed in search")
		}else{
			runAPI()
		}
		
	}
	
	func getAPICount() {
		
		if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil){
			let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
			limit = theValue
			
		}
		
		let formatter = NSDateFormatter()
		formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
		let refreshDte = formatter.stringFromDate(NSDate())
		
		refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDte)")
	}
	
	
	func runAPI() {
		
		getAPICount()
		
		//Call API
		let api = APIManager()
		
		api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: didLoadData)
	}
	
	
	// Is called just as the object is about to be deallocated
	deinit
	{
		NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
		
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification,object: nil)
	}
	
	
	func didLoadData(videos: [Videos]){
		
		print(reachabilityStatus)
		
		self.videos = videos // put the parameter videos into our variable videos
		
		/*
		for item in videos {
		print("name = \(item.vName)")
		}
		
		// if you want to have a index value of the array, you should do this way
		for (index, item) in videos.enumerate() {
		print("\(index) name = \(item.vName)")
		}
		*/
		
		navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
		
		title = ("The iTunes Top \(limit) Music Videos")
		
		
		//Setup the Search Controller 
		
		resultSearchController.searchResultsUpdater = self
		
		definesPresentationContext = true
		
		resultSearchController.dimsBackgroundDuringPresentation = false
		
		resultSearchController.searchBar.placeholder = "Search for Artist, Song Name, Rank"
		
		resultSearchController.searchBar.searchBarStyle = .Prominent
		
		// add search bar to your tableview
		tableView.tableHeaderView = resultSearchController.searchBar
		
		
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
		if resultSearchController.active{
			return filterSearch.count
		}
		return videos.count
	}
	
	private struct storyboard{
		static let cellReuseIdentifier = "cell"
		static let segueIdentifier = "musicDetail"
		
		
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell
		
		if resultSearchController.active {
			cell.video = filterSearch[indexPath.row]
		}else{
			// Configure the cell...
			cell.video = videos[indexPath.row]
		}
		
		
		
		
		
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
	
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		if segue.identifier == storyboard.segueIdentifier {
			
			if let indexPath = tableView.indexPathForSelectedRow {
				
				let video: Videos
				
				if resultSearchController.active{
					 video = filterSearch[indexPath.row]
				}else{
					 video = videos[indexPath.row]
				}
				
				let dvc = segue.destinationViewController as! MusicVideoDetailVC
				
				dvc.videos = video
			}
		}
		
		// Get the new view controller using segue.destinationViewController.
		// Pass the selected object to the new view controller.
	}
	
//	func updateSearchResultsForSearchController(searchController: UISearchController) {
//		searchController.searchBar.text?.lowercaseString
//		filterSearch(searchController.searchBar.text!)
//	}
	
	func filterSearch(searchText:String){
		
		filterSearch = videos.filter({ videos  in
			return videos.vArtist.lowercaseString.containsString(searchText.lowercaseString) || videos.vName.lowercaseString.containsString(searchText.lowercaseString) || "\(videos.vRank)".lowercaseString.containsString(searchText.lowercaseString)
		})
		
		tableView.reloadData()
		
	}
	
	
	
	
	
}
//
//extension MusicVideoTVC: UISearchResultsUpdating{
//	func updateSearchResultsForSearchController(searchController: UISearchController) {
//		searchController.searchBar.text?.lowercaseString
//		filterSearch(searchController.searchBar.text!)
//	}
//}
