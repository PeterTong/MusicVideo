//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by KwokWing Tong on 29/6/2016.
//  Copyright © 2016 Tong Kwok Wing. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MusicVideoDetailVC: UIViewController {
	
	var videos:Videos!
	
	@IBOutlet weak var vName: UILabel!
	
	@IBOutlet weak var videoImage: UIImageView!
	
	@IBOutlet weak var vGenre: UILabel!
	
	@IBOutlet weak var vRights: UILabel!
	
	@IBOutlet weak var vPrice: UILabel!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(preferredFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)
		
		title = videos.vArtist
		
		vName.text = videos.vName
		vGenre.text = videos.vGenre
		vPrice.text = videos.vPrice
		vRights.text = videos.vRights
		
		if videos.vImageData != nil {
			videoImage.image = UIImage(data: videos.vImageData!)
		}else{
			videoImage.image = UIImage(named: "imageNotAvailable")
		}
		
	}
	
	@IBAction func socialMedia(sender: UIBarButtonItem) {
		
		shareMedia()
		
		
	}
	
	
	func shareMedia() {
		
		let activity1 = "Have you had the opportunity to see this Music Video?"
		let activity2 = ("\(videos.vName) by \(videos.vArtist)")
		let activity3 = "Watch it and tell me what you think?"
		let activity4 = videos.vLinktoiTunes
		let activity5 = "(Shared with the Music Video App - Step It UP!)"
		
		let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3, activity4,activity5], applicationActivities: nil)
		
		//activityViewController.excludedActivityTypes =  [UIActivityTypeMail]
		
		
		
		//        activityViewController.excludedActivityTypes =  [
		//            UIActivityTypePostToTwitter,
		//            UIActivityTypePostToFacebook,
		//            UIActivityTypePostToWeibo,
		//            UIActivityTypeMessage,
		//            UIActivityTypeMail,
		//            UIActivityTypePrint,
		//            UIActivityTypeCopyToPasteboard,
		//            UIActivityTypeAssignToContact,
		//            UIActivityTypeSaveToCameraRoll,
		//            UIActivityTypeAddToReadingList,
		//            UIActivityTypePostToFlickr,
		//            UIActivityTypePostToVimeo,
		//            UIActivityTypePostToTencentWeibo
		//        ]
		
		activityViewController.completionWithItemsHandler = {
			(activity, success, items, error) in
			
			if activity == UIActivityTypeMail {
				print ("email selected")
			}
			
		}
		
		self.presentViewController(activityViewController, animated: true, completion: nil)

		
		
		
	}
	
	@IBAction func playVideo(sender: UIBarButtonItem) {
		
		let url = NSURL(string: videos.vVideoUrl)
		
		let player = AVPlayer(URL: url!)
		
		let playerViewController = AVPlayerViewController()
		
		playerViewController.player = player
		
		self.presentViewController(playerViewController, animated: true) { 
			playerViewController.player?.play()
		}
		
	}
	func preferredFontChange(){
		print("the preferred font has changed")
		vName.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
		vGenre.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
		vPrice.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
		vRights.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
		
	}
	
	deinit{
		
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
		
	}
	
	
}
