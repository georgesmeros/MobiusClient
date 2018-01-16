//
//  DataFeed.swift
//  MobiusClient
//
//  Created by HARE on 15/01/2018.
//  Copyright © 2018 gsmeros. All rights reserved.
//

import Foundation

/// Mobius API Client
public class MobiusAPIClient {
    private let baseURLEndpoint = "https://mobius.network/api/v1/"
    private let session = URLSession(configuration: .default)
    private let api_key: String
    
    public init(apiKey: String) {
        self.api_key = apiKey
    }
    
    /// Get balance of credits for email. Users transfer credits into apps on the DApp store and you can then query the number of credits a user currently has in your app.
    ///
    /// - Parameters:
    ///   - app_uid: The UID of the app. Get it at https://mobius.network/store/developer
    ///   - email: The email of the user whose balance you want to query.
    ///   - completion: balance
    public func getBalance(app_uid: String? = nil, email: String? = nil, _ completion: @escaping (_ balance: MobiusBalance?,_ errorMessage: String?,_ statusCode: Int?) -> Void) {
        let request = GetBalance.init(email: email, app_uid: app_uid)
        let endpoint = self.endpoint(for: request)
        let urlRequest = URLRequest(url: endpoint)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                if let data = data, status == 200 {
                    do {
                        
                        guard let json = try JSONSerialization.jsonObject(with: data, options: [])
                            as? [String: Any] else {
                                completion(nil, "decoding error", status)
                                return
                        }
                        completion(MobiusBalance.fromJSON(json: json), nil, status)
                    } catch {
                        completion(nil, "decoding error", status)
                    }
                } else {
                    let error = MobiusError(rawValue: status) ?? MobiusError.Generic
                    completion(nil, error.getMessage(), status)
                }
            }
        }
        task.resume()
    }
    
    /// Buys a Data Feed and sends its data to a Ethereum Contract Address.
    ///
    /// - Parameters:
    ///   - data_feed_uid: The UID of the Data Feed
    ///   - address: Ethereum Contract Address that will receive data
    ///   - completion: Data feed
    public func buyDataFeed(data_feed_uid: String? = nil, address: String? = nil, _ completion: @escaping (_ balance: MobiusDataFeed?,_ errorMessage: String?,_ statusCode: Int?) -> Void) {
        
        let request = BuyDataFeed.init(data_feed_uid: data_feed_uid, address: address)
        let endpoint = self.endpoint(for: request)
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                if let data = data, status == 200 {
                    do {
                        
                        guard let json = try JSONSerialization.jsonObject(with: data, options: [])
                            as? [String: Any] else {
                                completion(nil, "decoding error", status)
                                return
                        }
                        if let datafeedJSON = json["data_feed"] as? [String: Any] {
                            completion(MobiusDataFeed.fromJSON(json: datafeedJSON), nil, status)
                        }
                    } catch {
                        completion(nil, "decoding error", status)
                    }
                } else {
                    let error = MobiusError(rawValue: status) ?? MobiusError.Generic
                    completion(nil, error.getMessage(), status)
                }
            }
        }
        task.resume()
    }
    
    
    /// Returns DataFeed and last update timestamp, updated when new DataPoints are added.
    ///
    /// - Parameters:
    ///   - data_feed_uid: The UID of the Data Feed
    ///   - completion: Data Feed
    public func getDataFeed(data_feed_uid: String? = nil, _ completion: @escaping (_ dataFeed: MobiusDataFeed?,_ errorMessage: String?,_ statusCode: Int?) -> Void) {
        let request = GetDataFeed.init(data_feed_uid: data_feed_uid)
        let endpoint = self.endpoint(for: request)
        let urlRequest = URLRequest(url: endpoint)
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                if let data = data, status == 200 {
                    do {
                        
                        guard let json = try JSONSerialization.jsonObject(with: data, options: [])
                            as? [String: Any] else {
                                completion(nil, "decoding error", status)
                                return
                        }
                        
                        if let datafeedJSON = json["data_feed"] as? [String: Any] {
                            completion(MobiusDataFeed.fromJSON(json: datafeedJSON), nil, status)
                        }
                    } catch {
                        completion(nil, "decoding error", status)
                    }
                } else {
                    let error = MobiusError(rawValue: status) ?? MobiusError.Generic
                    completion(nil, error.getMessage(), status)
                }
            }
        }
        task.resume()
    }
    
    /// Creates a new DataPoint for the DataFeed with JSON values. Only the Data Feed owner is allowed to use this endpoint.
    ///
    /// - Parameters:
    ///   - data_feed_uid: The UID of the Data Feed
    ///   - values: JSON object representing the DataPoint
    ///   - completion: Data Feed
    public func createDataPoint(data_feed_uid: String? = nil,values: [String: Any]? = nil, _ completion: @escaping (_ dataFeed: MobiusDataFeed?,_ errorMessage: String?,_ statusCode: Int?) -> Void) {
        let request = CreateDataPoint.init(data_feed_uid: data_feed_uid)
        let endpoint = self.endpoint(for: request, values: values)
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"

        if let jsonData = try? JSONSerialization.data(withJSONObject: values ?? [:]), let string = String.init(data: jsonData, encoding: String.Encoding.utf8), let param = string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            urlRequest.url = urlRequest.url?.appendingPathComponent("&values=\(param)")
        }
    
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                if let data = data, status == 200 {
                    do {
                        
                        guard let json = try JSONSerialization.jsonObject(with: data, options: [])
                            as? [String: Any] else {
                                completion(nil, "decoding error", status)
                                return
                        }
                        completion(MobiusDataFeed.fromJSON(json: json), nil, status)
                    } catch {
                        completion(nil, "decoding error", status)
                    }
                } else {
                    let error = MobiusError(rawValue: status) ?? MobiusError.Generic
                    completion(nil, error.getMessage(), status)
                }
            }
        }
        task.resume()
    }
    
    /// Register a token so you can use it with the other Token API calls.
    ///
    /// - Parameters:
    ///   - token_type: Supported values: "erc20" or "stellar"
    ///   - name: The name of the token.
    ///   - symbol: The symbol of the token.
    ///   - issuer: The issuer of the token.
    ///   - completion: Token
    public func registerToken(token_type: TokenType?, name: String? = nil, symbol: String? = nil, issuer: String? = nil, _ completion: @escaping (_ balance: MobiusToken?,_ errorMessage: String?,_ statusCode: Int?) -> Void) {
        
        let request = RegisterToken.init(token_type: token_type, name: name, symbol: symbol, issuer: issuer)
        let endpoint = self.endpoint(for: request)
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                if let data = data, status == 200 {
                    do {
                        
                        guard let json = try JSONSerialization.jsonObject(with: data, options: [])
                            as? [String: Any] else {
                                completion(nil, "decoding error", status)
                                return
                        }
                        completion(MobiusToken.fromJSON(json: json), nil, status)
                    } catch {
                        completion(nil, "decoding error", status)
                    }
                } else {
                    let error = MobiusError(rawValue: status) ?? MobiusError.Generic
                    completion(nil, error.getMessage(), status)
                }
            }
        }
        task.resume()
    }
    
    /// Create an address for the token specified by token_uid.
    ///
    /// - Parameters:
    ///   - token_uid: The UID of the token - returned by /register.
    ///   - completion: uid / address
    public func createAddress(token_uid: String?, _ completion: @escaping (_ uid: String?,_ address: String?,_ errorMessage: String?,_ statusCode: Int?) -> Void) {
        let request = CreateAddress.init(token_uid: token_uid)
        let endpoint = self.endpoint(for: request)
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                if let data = data, status == 200 {
                    do {
                        
                        guard let json = try JSONSerialization.jsonObject(with: data, options: [])
                            as? [String: Any] else {
                                completion(nil, nil, "decoding error", status)
                                return
                        }
                        let uid = json["uid"] as? String
                        let address = json["address"] as? String
                        completion(uid, address, nil, status)
                    } catch {
                        completion(nil, nil, "decoding error", status)
                    }
                } else {
                    let error = MobiusError(rawValue: status) ?? MobiusError.Generic
                    completion(nil, nil, error.getMessage(), status)
                }
            }
        }
        task.resume()
    }
    
    /// Register an address for the token specified by token_uid. Registered addresses, like created addresses, are monitored for incoming transfers of the token specified via token_uid. When new tokens are transferred into the address, you are alerted via the token/transfer webhook callback.
    ///
    /// - Parameters:
    ///   - token_uid: The UID of the token - returned by /register.
    ///   - address: The address to register
    ///   - completion: uid
    public func registerAddress(token_uid: String?, address: String? = nil, _ completion: @escaping (_ uid: String?,_ errorMessage: String?,_ statusCode: Int?) -> Void) {
        let request = RegisterAddress.init(token_uid: token_uid, address: address)
        let endpoint = self.endpoint(for: request)
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                if let data = data, status == 200 {
                    do {
                        
                        guard let json = try JSONSerialization.jsonObject(with: data, options: [])
                            as? [String: Any] else {
                                completion(nil, "decoding error", status)
                                return
                        }
                        let uid = json["uid"] as? String
                        completion(uid, nil, status)
                    } catch {
                        completion(nil, "decoding error", status)
                    }
                } else {
                    let error = MobiusError(rawValue: status) ?? MobiusError.Generic
                    completion(nil, error.getMessage(), status)
                }
            }
        }
        task.resume()
    }
    
    /// Query the number of tokens specified by the token with token_uid that address has.
    ///
    /// - Parameters:
    ///   - token_uid: The UID of the token - returned by /register.
    ///   - address: The address whose balance you want to query.
    ///   - completion: address
    public func getAddressBalance(token_uid: String?, address: String? = nil, _ completion: @escaping (_ address: MobiusAddress?,_ errorMessage: String?,_ statusCode: Int?) -> Void) {
        let request = GetAddressBalance.init(token_uid: token_uid, address: address)
        let endpoint = self.endpoint(for: request)
        let urlRequest = URLRequest(url: endpoint)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                if let data = data, status == 200 {
                    do {
                        
                        guard let json = try JSONSerialization.jsonObject(with: data, options: [])
                            as? [String: Any] else {
                                completion(nil, "decoding error", status)
                                return
                        }
                        let address = MobiusAddress.fromJSON(json: json)
                        completion(address, nil, status)
                    } catch {
                        completion(nil, "decoding error", status)
                    }
                } else {
                    let error = MobiusError(rawValue: status) ?? MobiusError.Generic
                    completion(nil, error.getMessage(), status)
                }
            }
        }
        task.resume()
    }
    
    /// Transfer tokens from a Mobius managed address to a specified address. You must have a high enough balance to cover the transaction fees — on Ethereum this means paying the gas costs. Currently Mobius does not charge any fees itself.
    ///
    /// - Parameters:
    ///   - token_address_uid: Token Address UID (returned by /create_address)
    ///   - address_to: The address to send the tokens to.
    ///   - num_tokens: The number of tokens to trasnfer.
    ///   - completion: uid
    public func createTransfer(token_address_uid: String?, address_to: String? = nil, num_tokens: Double? = nil, _ completion: @escaping (_ uid: String?,_ errorMessage: String?,_ statusCode: Int?) -> Void) {
        let request = CreateTransfer.init(token_address_uid: token_address_uid, address_to: address_to, num_tokens: num_tokens)
        let endpoint = self.endpoint(for: request)
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                if let data = data, status == 200 {
                    do {
                        
                        guard let json = try JSONSerialization.jsonObject(with: data, options: [])
                            as? [String: Any] else {
                                completion(nil, "decoding error", status)
                                return
                        }
                        let tokenAddress = json["token_address_transfer_uid"] as? String
                        completion(tokenAddress, nil, status)
                    } catch {
                        completion(nil, "decoding error", status)
                    }
                } else {
                    let error = MobiusError(rawValue: status) ?? MobiusError.Generic
                    completion(nil, error.getMessage(), status)
                }
            }
        }
        task.resume()
    }
    
    
    /// Get the status and transaction hash of a Mobius managed token transfer.
    ///
    /// - Parameters:
    ///   - token_address_transfer_uid: The UID of the token address transfer returned by transfer/managed.
    ///   - completion: Transfer Info
    public func getTransferInfo(token_address_transfer_uid: String?, _ completion: @escaping (_ transferInfo: MobiusTransferInfo?,_ errorMessage: String?,_ statusCode: Int?) -> Void) {
        let request = GetTransferInfo.init(token_address_transfer_uid: token_address_transfer_uid)
        let endpoint = self.endpoint(for: request)
        let urlRequest = URLRequest(url: endpoint)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                if let data = data, status == 200 {
                    do {
                        
                        guard let json = try JSONSerialization.jsonObject(with: data, options: [])
                            as? [String: Any] else {
                                completion(nil, "decoding error", status)
                                return
                        }
                        let transferInfo = MobiusTransferInfo.fromJSON(json: json)
                        completion(transferInfo, nil, status)
                    } catch {
                        completion(nil, "decoding error", status)
                    }
                } else {
                    let error = MobiusError(rawValue: status) ?? MobiusError.Generic
                    completion(nil, error.getMessage(), status)
                }
            }
        }
        task.resume()
    }
    
    /// Use num_credits from user with email. This is similar to charging a users credit card. When a user uses credits in your app it means they are spending them and they are transferred to you. Returns true if successful and false if the user did not have enough credits.
    ///
    /// - Parameters:
    ///   - app_uid: The UID of the app. Get it at https://mobius.network/store/developer
    ///   - email: The email of the user whose credits you want to use.
    ///   - num_credits: The number of credits to use.
    ///   - completion: Balance
    public func useCredit(app_uid: String, email: String, num_credits: Double, completion: @escaping (_ newBalance: MobiusBalance?, _ errorMessage: String?,_ statusCode: Int?) -> Void) {
        let request = UseCredits.init(app_uid: app_uid, email: email, num_credits: num_credits)
        
        let endpoint = self.endpoint(for: request)
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                if let data = data, status == 200 {
                    do {
                        
                        guard let json = try JSONSerialization.jsonObject(with: data, options: [])
                            as? [String: Any] else {
                                completion(nil, "decoding error", status)
                                return
                        }
                        completion(MobiusBalance.fromJSON(json: json), nil, status)
                    } catch {
                        completion(nil, "decoding error", status)
                    }
                } else {
                    let error = MobiusError(rawValue: status) ?? MobiusError.Generic
                    completion(nil, error.getMessage(), status)
                }
            }
        }
        task.resume()
    }

	/// Encodes a URL based on the given request
	/// Everything needed for a public request to Marvel servers is encoded directly in this URL
    private func endpoint<T: APIRequest>(for request: T, values: [String: Any]? = nil) -> URL {
		guard let parameters = try? URLQueryEncoder.encode(request) else { fatalError("Wrong parameters") }

        guard let values = values else {
            // Construct the final URL with all the previous data
            return URL(string: "\(baseURLEndpoint)\(request.resourceName)?api_key=\(api_key)&\(parameters)")!
        }
        
        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        for (theKey, theValue) in values {
            jsonObject.setValue(theValue, forKey: theKey)
        }
        let jsonData: NSData
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
            let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)
            return URL(string: "\(baseURLEndpoint)\(request.resourceName)?api_key=\(api_key)&\(parameters)&values=\(String(describing: jsonString))")!
        } catch _ {
            return URL(string: "\(baseURLEndpoint)\(request.resourceName)?api_key=\(api_key)&\(parameters)")!
        }
	}
}
