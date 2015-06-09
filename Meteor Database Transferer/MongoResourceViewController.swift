//
//  MongoRecourceViewController.swift
//  Meteor Database Transferer
//
//  Created by Damiaan Dufaux on 29/05/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Cocoa
import MeteorTool

class MongoResourceViewController: NSTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	
	override func tabView(tabView: NSTabView, didSelectTabViewItem tabViewItem: NSTabViewItem?) {
		super.tabView(tabView, didSelectTabViewItem: tabViewItem)
		representedObject = tabViewItem!.viewController
	}
	
}