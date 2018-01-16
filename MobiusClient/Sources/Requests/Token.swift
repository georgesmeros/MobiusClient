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
    /// Supported values: "erc20" or "stellar"
    public let token_type: String?
    /// The name of the token.
    public let name: String?
    /// The symbol of the token.
    public let symbol: String?
    /// The issuer of the token.
    public let issuer: String?
    
    public init(token_type: TokenType? = nil,name: String? = nil,symbol: String? = nil,issuer: String? = nil) {
        self.token_type = token_type?.rawValue
        self.name = name
        self.symbol = symbol
        self.issuer = issuer
    }
}

struct CreateAddress: APIRequest {
    public typealias Response = [String: Any]
    
    public var resourceName: String {
        return "tokens/create_address"
    }
    
    // Parameters
    /// The UID of the token - returned by /register.
    public let token_uid: String?
    
    public init(token_uid: String? = nil) {
        self.token_uid = token_uid
    }
}

struct RegisterAddress: APIRequest {
    public typealias Response = [String: Any]
    
    public var resourceName: String {
        return "tokens/register_address"
    }
    
    // Parameters
    /// The UID of the token - returned by /register.
    public let token_uid: String?
    /// The address to register
    public let address: String?

    
    public init(token_uid: String? = nil, address: String? = nil) {
        self.token_uid = token_uid
        self.address = address
    }
}

struct GetAddressBalance: APIRequest {
    public typealias Response = MobiusAddress
    
    public var resourceName: String {
        return "tokens/balance"
    }
    
    // Parameters
    /// The UID of the token - returned by /register.
    public let token_uid: String?
    /// The address whose balance you want to query.
    public let address: String?
    
    
    public init(token_uid: String? = nil, address: String? = nil) {
        self.token_uid = token_uid
        self.address = address
    }
}

struct CreateTransfer: APIRequest {
    public typealias Response = String
    
    public var resourceName: String {
        return "tokens/transfer/managed"
    }
    
    // Parameters
    /// Token Address UID (returned by /create_address)
    public let token_address_uid: String?
    /// The address to send the tokens to.
    public let address_to: String?
    /// The number of tokens to trasnfer.
    public let num_tokens: Double?

    public init(token_address_uid: String? = nil, address_to: String? = nil, num_tokens: Double? = nil) {
        self.token_address_uid = token_address_uid
        self.address_to = address_to
        self.num_tokens = num_tokens
    }
}

struct GetTransferInfo: APIRequest {
    public typealias Response = MobiusTransferInfo
    
    public var resourceName: String {
        return "tokens/transfer/info"
    }
    
    // Parameters
    /// The UID of the token address transfer returned by transfer/managed.
    public let token_address_transfer_uid: String?
    
    public init(token_address_transfer_uid: String? = nil) {
        self.token_address_transfer_uid = token_address_transfer_uid
    }
}
