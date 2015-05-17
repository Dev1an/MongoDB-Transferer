//
//  MongoDB.swift
//  Meteor Database Transferer
//
//  Created by Damiaan Dufaux on 17/05/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Foundation
import ShellToolkit

public struct MongoURL: Printable {
	public let username: NSString?
	public let password: NSString?
	public let host: NSString
	public let database: NSString?
	
	public init (url: NSURL) {
		username = url.user
		password = url.password
		host = "\(url.host!):\(url.port!)"
		database = url.lastPathComponent
	}
	
	public var description: String {
		var result = ""
		for (key, value) in ["-u": username, "-p": password, "-h": host, "-d": database] {
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