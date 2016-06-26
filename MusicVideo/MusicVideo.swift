//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by KwokWing Tong on 25/6/2016.
//  Copyright © 2016 Tong Kwok Wing. All rights reserved.
//

import Foundation

class Videos {
  
  // Data Encapsulation
  
  private var _vName:String
  private var _vImageUrl:String
  private var _vVideoUrl:String
  
  private var _vRights:String
  private var _vPrice:String
  private var _vArtist:String
  private var _vImid:String
  private var _vGenre:String
  private var _vLinktoiTunes:String
  private var _vReleaseDate:String
  
  // This variable gets created from the UI
  var vImageData: NSData?
  
  
  //Make a getter
  
  var vRights:String{
    return _vRights
  }
  
  var vPrice:String{
    return _vPrice
  }
  
  var vArtist:String{
    return _vArtist
  }
  
  var vImid:String{
    return _vImid
  }
  
  var vGenre:String{
    return _vGenre
  }
  
  var vLinktoiTunes:String{
    return _vLinktoiTunes
  }
  
  var vReleaseDate:String{
    return _vReleaseDate
  }
  
  var vName: String {
    return _vName
  }
  
  var vImageUrl: String {
    return _vImageUrl
  }
  
  var vVideoUrl: String {
    return _vVideoUrl
  }
  
  
  
  init(data: JSONDictionary) {
    
    
    //If we do not initialize all properties we will get error message
    //Return from initializer without initializing all stored properties
    
    // Video Rights
    if let rights = data["rights"] as? JSONDictionary, label = rights["label"] as? String {
      _vRights = label
    }else{
      
      _vRights = ""
    }
    
    // Video Price 
    if let price = data["im:price"] as? JSONDictionary, label = price["label"] as? String {
      _vPrice = label
    }else{
      _vPrice = ""
    }
    
    // Video Artist
    if let artist = data["im:artist"] as? JSONDictionary, label = artist["label"] as? String {
      _vArtist = label
    }else{
      _vArtist = ""
    }
    
    // The Artist ID for iTunes Search API
    if let id = data["id"] as? JSONDictionary , attributes = id["attributes"] as? JSONDictionary, imid =
      attributes["im:id"] as? String {
      _vImid = imid
    }else{
      _vImid = ""
    }
    
    // The Genre
    if let category = data["category"] as? JSONDictionary, attributes = category["attributes"] as? JSONDictionary, term = attributes["term"] as? String{
      
      _vGenre = term
    }else {
      _vGenre = ""
    }
    
    // Video Link to iTunes
    if let id = data["id"] as? JSONDictionary, label = id["label"] as? String {
      _vLinktoiTunes = label
    }else{
      _vLinktoiTunes = ""
    }
    
    // Video Release Date 
    if let releaseDate = data["im:releaseDate"] as? JSONDictionary, attributes = releaseDate["attributes"] as? JSONDictionary, label = attributes["label"] as? String{
      
      _vReleaseDate = label
    }else{
      _vReleaseDate = ""
    }
    
    
    
    
    // Video name
    if let name = data["im:name"] as? JSONDictionary,
      vName = name["label"] as? String {
      self._vName = vName
    }
    else
    {
      //You may not always get data back from the JSON - you may want to display message
      // element in the JSON is unexpected
      
      _vName = ""
    }
    
    
    
    // The Video Image
    if let img = data["im:image"] as? JSONArray,
      image = img[2] as? JSONDictionary,
      immage = image["label"] as? String {
      _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
    }
    else
    {
      _vImageUrl = ""
    }
    
    
    
    //Video Url
    if let video = data["link"] as? JSONArray,
      vUrl = video[1] as? JSONDictionary,
      vHref = vUrl["attributes"] as? JSONDictionary,
      vVideoUrl = vHref["href"] as? String {
      self._vVideoUrl = vVideoUrl
    }
    else
    {
      _vVideoUrl = ""
    }
    
  }
  
}