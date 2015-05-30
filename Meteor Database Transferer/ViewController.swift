//
//  ViewController.swift
//  Meteor Database Transferer
//
//  Created by Damiaan Dufaux on 17/05/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Cocoa
import ShellToolkit
import MeteorTool

//class ViewController: NSViewController {
//	
//	dynamic var meteorApp: String? = nil
//	dynamic var busy = false
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//
//		// Do any additional setup after loading the view.
//	}
//
//	override var representedObject: AnyObject? {
//		didSet {
//		// Update the view, if already loaded.
//		}
//	}
//
//	@IBAction func test(sender: AnyObject) {
//		if let appUrl = meteorApp {
//			busy = true
//			getMongoCredentials(forMeteorApp: appUrl, errorHandler: showError) { credentials in
//				let temporaryDirectory = NSTemporaryDirectory() + "com.devian.meteorTool/dump/"
//				dumpMongoDatabase(credentials, temporaryDirectory) { result, error in
//					if let error = error {
//						println("error")
//						print(error)
//						self.busy = false
//					} else {
//						println("dumped in \(temporaryDirectory)")
//						self.busy = false
//					}
//				}
//			}
//		}
//	}
//	
//	func showError(error: NSError) {
//		busy = false
//		dispatch_sync(dispatch_get_main_queue(), {
//			let alert = NSAlert()
//			alert.messageText = error.userInfo?["description"] as? String
//			alert.informativeText = error.userInfo?["meteor help text"] as? String
//			alert.runModal()
//		})
//	}
//	
//	@IBAction func showTemp(sender: AnyObject) {
//		println(NSTemporaryDirectory())
//	}
//	
//}