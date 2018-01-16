//
//  MobiusAddress.swift
//  MobiusClient
//
//  Created by HARE on 16/01/2018.
//  Copyright © 2018 gsmeros. All rights reserved.
//

import Foundation

public class MobiusAddress: Decodable {
    
    public var addressHash: String?
    public var token: MobiusToken?
    public var balance: Double?
}

extension MobiusAddress {
    class func fromJSON(json: [String: Any]) -> MobiusAddress {
        let address = MobiusAddress()
        
        if let addressHash = json["address"] as? String {
            address.addressHash = addressHash
        }
        if let tokenJSON = json["token"] as? [String: Any] {
            let token = MobiusToken.fromJSON(json: tokenJSON)
            address.token = token
        }
        if let balanceString = json["balance"] as? String {
            address.balance = Double(balanceString)
        }
        
        return address
    }
}
