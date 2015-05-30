//
//  Command.swift
//  Meteor Database Transferer
//
//  Created by Damiaan Dufaux on 17/05/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Foundation

var commands = [Command]()

public typealias Reader = (String -> Void)

public class Command {
	
	let task = NSTask()
	
	let environmentDict = NSProcessInfo.processInfo().environment
	let arguments = ["-l", "-c"]
	
	var (output, error) = (NSPipe(), NSPipe())
	
	public init(input: String, outputReader: Reader? = nil, errorReader: Reader? = nil, completionHandler: (()->())? = nil) {
		setTaskUp(input)
		
		output ->> outputReader
		error ->> errorReader
		
		if let completionHandler = completionHandler {
			task.terminationHandler = {task in completionHandler()}
		}
		
		task.launch()
	}
	
	public init(input: String, completionHandler: (String, String?)->Void) {
		setTaskUp(input)
		
		task.terminationHandler = { task in
			let output = self.output.fileHandleForReading.readDataToEndOfFile()
			let errors = self.error.fileHandleForReading.readDataToEndOfFile()
			let hasErrors = errors.length > 0
			let outString = NSString(data: output, encoding: NSUTF8StringEncoding) as! String
			let errString: String? = !hasErrors ? nil : NSString(data:  errors, encoding: NSUTF8StringEncoding) as? String
			completionHandler(outString, errString)
		}
		
		task.launch()
	}
	
	func setTaskUp(input: String) {
		let shellString = environmentDict["SHELL"] as! String

		task.standardOutput = output
		task.standardError = error
		
		task.launchPath = shellString
		task.arguments = arguments + [input]
	}
	
	public func terminate() {
		task.terminate()
	}
	
	public class func terminateAll() {
		for command in commands {
			command.terminate()
		}
	}
}

infix operator ->> {}
func ->> (pipe: NSPipe, reader: Reader?) {
	if let reader = reader {
		pipe.fileHandleForReading.readabilityHandler = { fileHandler in
			reader(NSString(data: fileHandler.availableData, encoding: NSUTF8StringEncoding) as! String)
		}
	}
}