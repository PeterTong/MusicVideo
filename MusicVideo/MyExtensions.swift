//
//  MyExtensions.swift
//  MusicVideo
//
//  Created by KwokWing Tong on 15/7/2016.
//  Copyright © 2016 Tong Kwok Wing. All rights reserved.
//

import UIKit

extension MusicVideoTVC: UISearchResultsUpdating{
	func updateSearchResultsForSearchController(searchController: UISearchController) {
		searchController.searchBar.text?.lowercaseString
		filterSearch(searchController.searchBar.text!)
	}
}