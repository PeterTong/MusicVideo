//
//  ViewController.swift
//  MusicVideo
//
//  Created by KwokWing Tong on 25/6/2016.
//  Copyright © 2016 Tong Kwok Wing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var videos = [Videos]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Call API
    let api = APIManager()
    
    api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    
  }

  func didLoadData(videos: [Videos]){
    
    self.videos = videos // put the parameter videos into our variable videos
    
    for item in videos {
      print("name = \(item.vReleaseDate)")
    }
    
    // if you want to have a index value of the array, you should do this way
    for (index, item) in videos.enumerate() {
      print("\(index) name = \(item.vName)")
    }
    
    
    //        for i in 0..<videos.count {
    //            let video = videos[i]
    //            print("\(i) name = \(video.vName)")
    //        }
    
    //        for var i = 0; i < videos.count; i++ {
    //            let video = videos[i]
    //            print("\(i) name = \(video.vName)")
    //        }
    
  }


}

