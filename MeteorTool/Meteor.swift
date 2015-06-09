//
//  Meteor.swift
//  Meteor Database Transferer
//
//  Created by Damiaan Dufaux on 17/05/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Foundation
import ShellTool

public class MeteorResource: NSObject, MongoResource {
	func getMongoServer(errorHandler: (NSError->Void)? = nil, completionHandler: (MongoServer)->Void) {}
	
	public func dump(path: String, errorHandler: NSError -> Void, completionHandler: (String) -> ()) {
		getMongoServer(errorHandler) { mongo in
			mongo.dump(path, errorHandler: errorHandler, completionHandler: completionHandler)
		}
	}
	
	public func restore(fromPath path: String, errorHandler: NSError -> Void, completionHandler: () -> ()) {
		getMongoServer(errorHandler) { database in
			database.restore(fromPath: path, errorHandler: errorHandler, completionHandler: completionHandler)
		}
	}
}

public class MeteorServer: MeteorResource {
	public dynamic var url = ""
	
	public override func getMongoServer(errorHandler: (NSError->Void)? = nil, completionHandler: (MongoServer)->Void) {
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
}

public class LocalMeteor: MeteorResource {
	public dynamic var location: String
	
	public init(location: String) {
		self.location = location
	}

	public override func getMongoServer(errorHandler: (NSError->Void)? = nil, completionHandler: (MongoServer)->Void) {
		Command(input: "cd \"\(location)\"; meteor mongo --url") { result, error in
			
			if let error = error {
				errorHandler?(NSError(domain: "meteor", code: 0, userInfo: [
					"description": "An error occured while trying to retreive login credentials for \(self.location).",
					"meteor help text": error
					]))
			} else {
				completionHandler(MongoServer(url: NSURL(string: result.componentsSeparatedByString("\n")[0])!))
			}
			
		}
	}
}

var mySites: [String]?

public func getMySites(callback: [String]->Void) {
	if let mySites = mySites {
		callback(mySites)
	} else {
		Command(input: "meteor list-sites") { output, errors in
			mySites = output.componentsSeparatedByString("\n").filter({$0.characters.count>0})
			callback(mySites!)
		}
	}
}

public func getRunningApps(callback: [String]->Void) {
	Command(input: "ps aux | egrep \"dev_bundle\\/bin\\/node.*?meteor\\/local\\/build\\/main\\.js\"") { output, error in
		callback(output["dev_bundle\\/bin\\/node\\s([\\S\\s]*?)\\.meteor\\/local\\/build\\/main\\.js"].allGroups().map {$0[1]})
	}
}