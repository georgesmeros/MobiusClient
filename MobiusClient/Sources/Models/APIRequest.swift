//
//  DataFeed.swift
//  MobiusClient
//
//  Created by HARE on 15/01/2018.
//  Copyright © 2018 gsmeros. All rights reserved.
//

import Foundation

public protocol APIRequest: Encodable {

	/// Endpoint for this request (the last part of the URL)
	var resourceName: String { get }
}
