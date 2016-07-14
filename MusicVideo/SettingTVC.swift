//
//  SettingTVC.swift
//  MusicVideo
//
//  Created by KwokWing Tong on 13/7/2016.
//  Copyright © 2016 Tong Kwok Wing. All rights reserved.
//

import UIKit
import MessageUI

class SettingTVC: UITableViewController,MFMailComposeViewControllerDelegate {
	
	@IBOutlet weak var aboutDisplay: UILabel!
	
	
	@IBOutlet weak var feedbackDisplay: UILabel!
	
	@IBOutlet weak var securityDisplay: UILabel!
	
	@IBOutlet weak var bestImageDisplay: UILabel!
	
	@IBOutlet weak var touchID: UISwitch!
	
	@IBOutlet weak var APICnt: UILabel!
	
	@IBOutlet weak var sliderCnt: UISlider!
	
	@IBOutlet weak var numberOfVideoDisplay: UILabel!
	
	@IBOutlet weak var dragTheSliderDisplay: UILabel!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(preferredFontChange), name: UIContentSizeCategoryDidChangeNotification, object: nil)// This is a way to viewcontroller for observer font size changed
		
		tableView.alwaysBounceVertical = false
		
		title = "Setting"
		
		touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
		
		if NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil {
			let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
			APICnt.text = "\(theValue)"
			sliderCnt.value = Float(theValue)
		}else{
			sliderCnt.value = 10.0
			APICnt.text = ("\(Int(sliderCnt.value))")
		}
		
		
	}
	@IBAction func valueChanged(sender: UISlider) {
		
		NSUserDefaults.standardUserDefaults().setObject(Int(sliderCnt.value), forKey: "APICNT")
		APICnt.text = ("\(Int(sliderCnt.value))")
	}
	@IBAction func touchIdSec(sender: UISwitch) {
		
		if touchID.on {
			NSUserDefaults.standardUserDefaults().setBool(touchID.on, forKey: "SecSetting")
		}else{
			NSUserDefaults.standardUserDefaults().setBool(false, forKey: "SecSetting")
		}
	}
	
	func preferredFontChange(){
		
		print("The preferred font is changed")
		
		aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
		feedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
		securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
		bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
		APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
		numberOfVideoDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
		dragTheSliderDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
		if indexPath.row == 1 && indexPath.section == 0 {
			
			let mailComposeViewController = configureMail()
			
			if MFMailComposeViewController.canSendMail() {
				
				self.presentViewController(mailComposeViewController, animated: true, completion: nil)
			}else{
				//no email setup on iPhone
				mailAlert()
			}
			
			tableView.deselectRowAtIndexPath(indexPath, animated: true)
			
		}
	}
	
	func configureMail() -> MFMailComposeViewController{
		
		let mailComposeVC = MFMailComposeViewController()
		mailComposeVC.mailComposeDelegate = self
		mailComposeVC.setToRecipients(["tkwpeter21@gmail.com"])
		mailComposeVC.setSubject("Music Video App Feedback")
		mailComposeVC.setMessageBody("Hi Peter,\n\n  I would like to share the following feedback...\n", isHTML: false)
		return mailComposeVC
	}
	
	func mailAlert() {
		
		let alertController = UIAlertController(title: "Alert", message: "No e-Mail Account setup in your device", preferredStyle: .Alert)
		
		let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
			
			// do something if you want
		}
		
		alertController.addAction(okAction)
		
		self.presentViewController(alertController, animated: true, completion: nil)
	}
	
	func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
		
		switch result.rawValue {
		case MFMailComposeResultCancelled.rawValue:
			print("Mail cancelled")
		case MFMailComposeResultSaved.rawValue:
			print("Mail saved")
		case MFMailComposeResultSent.rawValue:
			print("Mail sent")
		case MFMailComposeResultFailed.rawValue:
			print("Mail Failed")
			
		default:
			print("Unknown issue")
		}
		
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	deinit
	{
		
		
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification,object: nil)
	}
	
	
	
	
	
}
