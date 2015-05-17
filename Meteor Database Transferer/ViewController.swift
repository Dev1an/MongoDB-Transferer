//
//  ViewController.swift
//  Meteor Database Transferer
//
//  Created by Damiaan Dufaux on 17/05/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Cocoa
import ShellToolkit

struct MongoURL: Printable {
	let username: NSString?
	let password: NSString?
	let host: NSString
	let database: NSString?
	
	init (url: NSURL) {
		username = url.user
		password = url.password
		host = "\(url.host!):\(url.port!)"
		database = url.lastPathComponent
	}
	
	func needsAuthorisation() -> Bool { return username != nil && password != nil }
	
	var description: String {
		return "user: \(username!), password: \(password!), host: \(host), database: \(database!)"
	}
}

class ViewController: NSViewController {
	
	dynamic var meteorApp: String? = nil
	dynamic var busy = false

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

	override var representedObject: AnyObject? {
		didSet {
		// Update the view, if already loaded.
		}
	}

	@IBAction func test(sender: AnyObject) {
		if let appUrl = meteorApp {
			busy = true
			Command(input: "meteor mongo --url \(appUrl)") { result, error in
				
				if let error = error {
					dispatch_sync(dispatch_get_main_queue(), {
						let alert = NSAlert()
						alert.messageText = "An error occured while trying to retreive login credentials for \(appUrl)."
						alert.informativeText = error
						alert.runModal()
					})
				} else {
					println(MongoURL(url: NSURL(string: result.componentsSeparatedByString("\n")[0])!))
				}
				
				self.busy = false
			}
		}
	}
	
}