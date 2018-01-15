//
//  Token.swift
//  MobiusClient
//
//  Created by HARE on 15/01/2018.
//  Copyright © 2018 gsmeros. All rights reserved.
//

import Foundation

public enum TokenType: String {
    case erc20 = "erc20"
    case stellar = "stellar"
}

struct RegisterToken: APIRequest {
    public typealias Response = MobiusToken
    
    public var resourceName: String {
        return "tokens/register"
    }
    
    // Parameters
    public let token_type: String?
    public let name: String?
    public let symbol: String?
    public let issuer: String?
    
    public init(token_type: TokenType? = nil,name: String? = nil,symbol: String? = nil,issuer: String? = nil) {
        self.token_type = token_type?.rawValue
        self.name = name
        self.symbol = symbol
        self.issuer = issuer
    }
}

struct CreateAddress: APIRequest {
    public typealias Response = MobiusToken
    
    public var resourceName: String {
        return "tokens/create_address"
    }
    
    // Parameters
    public let token_type: String?
    public let name: String?
    public let symbol: String?
    public let issuer: String?
    
    public init(token_type: TokenType? = nil,name: String? = nil,symbol: String? = nil,issuer: String? = nil) {
        self.token_type = token_type?.rawValue
        self.name = name
        self.symbol = symbol
        self.issuer = issuer
    }
}
