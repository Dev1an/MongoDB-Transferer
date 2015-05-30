//
//  TransFerViewController.swift
//  Meteor Database Transferer
//
//  Created by Damiaan Dufaux on 30/05/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Cocoa
import MeteorTool

class TransferViewController: NSViewController {
	
	dynamic var sourceController: MongoResourceViewController!
	dynamic var destinationController: MongoResourceViewController!
	@IBOutlet var spinner: NSProgressIndicator!

	@IBAction func transfer(sender: NSButton) {
		
	}
	
	var source: MongoResource? {
		return sourceController.representedObject?.representedObject as? MongoResource
	}
	var destination: MongoResource? {
		return destinationController.representedObject?.representedObject as? MongoResource
	}
	
	override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "sourceController" {
			sourceController = (segue.destinationController as! MongoResourceViewController)
		}
		else if segue.identifier == "destinationController" {
			destinationController = (segue.destinationController as! MongoResourceViewController)
		}
	}
	
}
