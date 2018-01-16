//
//  MobiusTransferInfo.swift
//  MobiusClient
//
//  Created by HARE on 16/01/2018.
//  Copyright © 2018 gsmeros. All rights reserved.
//

import Foundation

public enum MobiusStatus: String {
    case error = "error"
    case pending = "pending"
    case sent = "sent"
    case complete = "complete"
}

public class MobiusTransferInfo: NSObject {
    
    /// The token_address_transfer_uid
    public var uid: String?
    
    /// error, pending, sent, or complete
    public var status: MobiusStatus?
    
    /// hash of the transaction once it has been sent.
    public var tx_hash: String?
}

extension MobiusTransferInfo {
    class func fromJSON(json: [String: Any]) -> MobiusTransferInfo {
        let info = MobiusTransferInfo()
        if let uid = json["uid"] as? String {
            info.uid = uid
        }
        if let status = json["status"] as? String {
            switch status {
            case "error":
                info.status = .error
            case "pending":
                info.status = .pending
            case "sent":
                info.status = .sent
            case "complete":
                info.status = .complete
            default:
                info.status = .error
            }
        }
        if let tx_hash = json["tx_hash"] as? String {
            info.tx_hash = tx_hash
        }
        
        return info
    }
}
