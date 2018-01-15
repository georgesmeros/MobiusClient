//
//  DataFeed.swift
//  MobiusClient
//
//  Created by HARE on 15/01/2018.
//  Copyright © 2018 gsmeros. All rights reserved.
//

import Foundation

public struct UseCredits: APIRequest {
    public typealias Response = MobiusBalance
    
    // Notice how we create a composed resourceName
    public var resourceName: String {
        return "app_store/use"
    }
    
    // Parameters
    private let app_uid: String?
    private let email: String?
    private let num_credits: Double?
    
    public init(app_uid: String? = nil, email: String? = nil, num_credits: Double? = nil) {
        self.app_uid = app_uid
        self.email = email
        self.num_credits = num_credits
    }
}

