//
//  Meteor.swift
//  Meteor Database Transferer
//
//  Created by Damiaan Dufaux on 17/05/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Foundation
import ShellToolkit

public func getMongoCredentials(forMeteorApp app: String, errorHandler: (NSError->Void)? = nil, completionHandler: (MongoURL)->Void) {
	Command(input: "meteor mongo --url \(app)") { result, error in
		
		if let error = error {
			errorHandler?(NSError(domain: "meteor", code: 0, userInfo: [
				"description": "An error occured while trying to retreive login credentials for \(app).",
				"meteor help text": error
			]))
		} else {
			completionHandler(MongoURL(url: NSURL(string: result.componentsSeparatedByString("\n")[0])!))
		}
		
	}
}