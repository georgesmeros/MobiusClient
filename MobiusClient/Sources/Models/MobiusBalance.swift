//
//  MobiusBalance.swift
//  MobiusClient
//
//  Created by Macbook on 12/01/2018.
//  Copyright © 2018 gsmeros. All rights reserved.
//

import Foundation

public class MobiusBalance: Decodable {
    public var credits: Double?
}

extension MobiusBalance {
    class func fromJSON(json: [String: Any]) -> MobiusBalance {
        let balance = MobiusBalance()
        if let credits = json["num_credits"] as? Double {
            balance.credits = credits
        }
        return balance
    }
}
