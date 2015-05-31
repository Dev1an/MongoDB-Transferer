//
//  LocalMeteorResourceViewController.swift
//  Meteor Database Transferer
//
//  Created by Damiaan Dufaux on 31/05/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Cocoa
import MeteorTool

class LocalMeteorResourceViewController: NSViewController {

	dynamic var runningApps = [String]()
	dynamic var app: String? {
		didSet {
			if let app = app {
				if let resource = representedObject as? LocalMeteor {
					resource.location = app
				} else {
					representedObject = LocalMeteor(location: app)
				}
			} else {
				representedObject = nil
			}
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		getRunningApps { apps in
			self.runningApps += apps
		}
    }
    
}
