//
//  MobiusDataFeed.swift
//  MobiusClient
//
//  Created by Macbook on 12/01/2018.
//  Copyright © 2018 gsmeros. All rights reserved.
//

import Foundation

public class MobiusDataFeed: NSObject {
    
    public var uid: Int?
    public var name: String?
    public var imageURL: String?
    public var feedDescription: String?
    public var price: Double?
    public var descriptor: [String: Any]?
    public var lastUpdated: String?
}

extension MobiusDataFeed {
    class func fromJSON(json: [String: Any]) -> MobiusDataFeed {
        let feed = MobiusDataFeed()
        
        if let uid = json["uid"] as? Int {
            feed.uid = uid
        }
        if let name = json["name"] as? String {
            feed.name = name
        }
        if let imageURL = json["imageUrl"] as? String {
            feed.imageURL = imageURL
        }
        if let feedDescription = json["description"] as? String {
            feed.feedDescription = feedDescription
        }
        if let price = json["price"] as? Double {
            feed.price = price
        }
        if let descriptor = json["descriptor"] as? [String: Any] {
            feed.descriptor = descriptor
        }
        if let lastUpdated = json["last_updated"] as? String {
            feed.lastUpdated = lastUpdated
        }
        
        return feed
    }
}
