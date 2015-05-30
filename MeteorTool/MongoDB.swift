//
//  MongoDB.swift
//  Meteor Database Transferer
//
//  Created by Damiaan Dufaux on 17/05/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Foundation
import ShellToolkit

@objc public protocol MongoResource: NSObjectProtocol {
	func dump(path: String, errorHandler: NSError->Void, completionHandler: ()->())
	func restore(fromPath path: String, errorHandler: NSError->Void, completionHandler: ()->())
}

public class MongoServer: NSObject, MongoResource {
	public var username: NSString?
	public var password: NSString?
	public var host: NSString?
	public var port: NSNumber?
	public var database: NSString?
	
	public init (url: NSURL) {
		username = url.user
		password = url.password
		host = url.host
		port = url.port
		database = url.lastPathComponent
	}
	
	func shellOptionString() -> String {
		let shellOptions = [
			"-u": username,
			"-p": password,
			"--host": host,
			"--port": "\(port)",
			"-d": database
		]
		
		var result = ""
		for (key, value) in shellOptions {
			if let value = value {
				result += "\(key) \(value) "
			}
		}
		return result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
	}
	
	override public var description: String {
		return shellOptionString()
	}
	
	public func dump(path: String, errorHandler: NSError -> Void, completionHandler: () -> ()) {
		Command(input: "mongodump \(self) -o \(path)", completionHandler: completionHandler)
	}
	
	public func restore(fromPath path: String, errorHandler: NSError -> Void, completionHandler: () -> ()) {
		Command(input: "mongorestore \(path) \(self)", completionHandler: completionHandler)
	}
}

public func transfer(source: MongoResource, destination: MongoResource, errorHandler: NSError -> Void, completionHandler: ()->()) {
	let temporaryDirectory = NSTemporaryDirectory() + "com.devian.meteorTool/dump/"
	source.dump(temporaryDirectory, errorHandler: errorHandler) {
		destination.restore(fromPath: temporaryDirectory, errorHandler: errorHandler, completionHandler: completionHandler)
	}
}