//
//  TabViewController.swift
//  Meteor Database Transferer
//
//  Created by Damiaan Dufaux on 30/05/15.
//  Copyright (c) 2015 Damiaan Dufaux. All rights reserved.
//

import Cocoa

class TabViewController: NSTabViewController {

	var viewControllers = TypeDictionary()
	
	override func addTabViewItem(tabViewItem: NSTabViewItem) {
		super.addTabViewItem(tabViewItem)
		if let viewController = tabViewItem.viewController {
			viewControllers.add(viewController)
		}
	}
	
	func viewControllerWithType<T: NSObject>(type: T.Type) -> T? {
		return viewControllers.get(type)
	}
}

class TypeDictionary {
	var dict = [String: NSObject]()
	
	func get<T: NSObject>(key: T.Type) -> T? {
		return dict[T.className()] as? T
	}
	
	func set<T: NSObject>(key: T.Type, value: T) {
		dict[key.className()] = value
	}
	
	func add<T: NSObject>(value: T) {
		set(value.dynamicType, value: value)
	}
}