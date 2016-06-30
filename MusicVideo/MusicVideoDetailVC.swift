//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by KwokWing Tong on 29/6/2016.
//  Copyright © 2016 Tong Kwok Wing. All rights reserved.
//

import UIKit

class MusicVideoDetailVC: UIViewController {
	
	var videos:Videos!
	
	@IBOutlet weak var vName: UILabel!
	
	@IBOutlet weak var videoImage: UIImageView!
	
	@IBOutlet weak var vGenre: UILabel!
	
	@IBOutlet weak var vRights: UILabel!
	
	@IBOutlet weak var vPrice: UILabel!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
	
	
}
