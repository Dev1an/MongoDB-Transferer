//
//  MongoServerViewController.swift
//  Meteor Database Transferer
//
//  Created by Damiaan Dufaux on 31/05/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Cocoa
import MeteorTool

class MongoServerViewController: NSViewController {
	dynamic var server = MongoServer()
	
	@IBAction func setObject(sender: NSTextField) {
		representedObject = server.host != nil ? server : nil
	}
	
}