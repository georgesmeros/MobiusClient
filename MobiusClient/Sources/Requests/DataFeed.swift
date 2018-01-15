//
//  DataFeed.swift
//  MobiusClient
//
//  Created by HARE on 15/01/2018.
//  Copyright © 2018 gsmeros. All rights reserved.
//

import Foundation

struct GetDataFeed: APIRequest {
    public typealias Response = MobiusDataFeed
    
    public var resourceName: String {
        return "data_marketplace/data_feed"
    }
    
    // Parameters
    public let data_feed_uid: String?
    
    public init(data_feed_uid: String? = nil) {
        self.data_feed_uid = data_feed_uid
    }
}

struct CreateDataPoint: APIRequest {
    public typealias Response = MobiusDataFeed
    
    public var resourceName: String {
        return "data_marketplace/data_feed"
    }
    
    // Parameters
    public let data_feed_uid: String?
    
    public init(data_feed_uid: String? = nil) {
        self.data_feed_uid = data_feed_uid
    }
}

struct BuyDataFeed: APIRequest {
    public typealias Response = MobiusDataFeed
    
    public var resourceName: String {
        return "data_marketplace/data_feed"
    }
    
    // Parameters
    public let data_feed_uid: String?
    public let address: String?
    
    public init(data_feed_uid: String? = nil, address: String? = nil) {
        self.data_feed_uid = data_feed_uid
        self.address = address
    }
}
