//
//  MongoDB.swift
//  Meteor Database Transferer
//
//  Created by Damiaan Dufaux on 17/05/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Foundation
import ShellToolkit

@objc public protocol MongoResource {
	/// returns whether this is valid resource or not
//	func checkValid()
//	
//	var isValid: Bool {get}
}

public class MongoURL: Printable, MongoResource {
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
	
	public var description: String {
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
}

public func dumpMongoDatabase(url: MongoURL, destination: String, callback: (String, String?)->Void) {
	Command(input: "pwd; mongodump \(url) -o \(destination)", completionHandler: callback)
}

public func restoreMongoDatabase(source: String, destination: MongoURL, callback: (String, String?)->Void) {
	Command(input: "mongorestore \(source) \(destination)", completionHandler: callback)
}