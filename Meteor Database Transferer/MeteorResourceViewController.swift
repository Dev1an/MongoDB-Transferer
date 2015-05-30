//
//  MeteorResourceViewController.swift
//  Meteor Database Transferer
//
//  Created by Damiaan Dufaux on 30/05/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Cocoa
import MeteorTool

class MeteorResourceViewController: NSViewController {
	
	var url: String? = nil {
		didSet {
			if let url = url {
				if let resource = representedObject as? MeteorServer {
					resource.url = url
				} else {
					representedObject = MeteorServer()
					(representedObject as! MeteorServer).url = url
				}
			} else {
				representedObject = nil
			}
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
