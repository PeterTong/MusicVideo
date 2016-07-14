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
