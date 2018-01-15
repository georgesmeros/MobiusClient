//
//  MobiusToken.swift
//  MobiusClient
//
//  Created by HARE on 15/01/2018.
//  Copyright © 2018 gsmeros. All rights reserved.
//

import Foundation

public class MobiusToken: Decodable {
    public var uid: String?
    public var token_type: String?
    public var name: String?
    public var symbol: String?
    public var issuer: String?
}

extension MobiusToken {
    class func fromJSON(json: [String: Any]) -> MobiusToken {
        let token = MobiusToken()
        if let uid = json["uid"] as? String {
            token.uid = uid
        }
        if let token_type = json["token_type"] as? String {
            token.token_type = token_type
        }
        if let name = json["name"] as? String {
            token.name = name
        }
        if let symbol = json["symbol"] as? String {
            token.symbol = symbol
        }
        if let issuer = json["issuer"] as? String {
            token.issuer = issuer
        }
        
        return token
    }
}
