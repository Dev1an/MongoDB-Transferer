//
//  Meteor.swift
//  Meteor Database Transferer
//
//  Created by Damiaan Dufaux on 17/05/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Foundation
import ShellToolkit

public class MeteorServer: NSObject, MongoResource {
	public dynamic var url = ""
	
	public func getMongoServer(errorHandler: (NSError->Void)? = nil, completionHandler: (MongoServer)->Void) {
		Command(input: "meteor mongo --url \(url)") { result, error in
			
			if let error = error {
				errorHandler?(NSError(domain: "meteor", code: 0, userInfo: [
					"description": "An error occured while trying to retreive login credentials for \(self.url).",
					"meteor help text": error
					]))
			} else {
				completionHandler(MongoServer(url: NSURL(string: result.componentsSeparatedByString("\n")[0])!))
			}
			
		}
	}
	
	public func dump(path: String, errorHandler: NSError -> Void, completionHandler: (String) -> ()) {
		getMongoServer(errorHandler: errorHandler) { mongo in
			mongo.dump(path, errorHandler: errorHandler, completionHandler: completionHandler)
		}
	}
	
	public func restore(fromPath path: String, errorHandler: NSError -> Void, completionHandler: () -> ()) {
		getMongoServer(errorHandler: errorHandler) { database in
			database.restore(fromPath: path, errorHandler: errorHandler, completionHandler: completionHandler)
		}
	}
}
//
//public func dumpMeteorDatabase(app: MeteorResource)