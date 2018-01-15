//
//  DataFeed.swift
//  MobiusClient
//
//  Created by HARE on 15/01/2018.
//  Copyright © 2018 gsmeros. All rights reserved.
//

import Foundation

public enum Result<Value> {
	case success(Value)
	case failure(Error)
}

public typealias ResultCallback<Value> = (Result<Value>) -> Void
