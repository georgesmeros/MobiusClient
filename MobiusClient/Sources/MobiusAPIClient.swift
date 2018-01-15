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
    
    public func getBalance(_ app_uid: String? = nil,_ email: String? = nil, _ completion: @escaping (_ balance: MobiusBalance?,_ errorMessage: String?,_ statusCode: Int?) -> Void) {
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
    
    public func getDataFeed(_ data_feed_uid: String? = nil,_ values: [String: Any]? = nil, _ completion: @escaping (_ dataFeed: MobiusDataFeed?,_ errorMessage: String?,_ statusCode: Int?,_ path: String?) -> Void) {
        let request = GetDataFeed.init(data_feed_uid: data_feed_uid)
        let endpoint = self.endpoint(for: request, values: values)
        var urlRequest = URLRequest(url: endpoint)
        
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
                                completion(nil, "decoding error", status, urlRequest.url?.absoluteString)
                                return
                        }
                        completion(MobiusDataFeed.fromJSON(json: json), nil, status, urlRequest.url?.absoluteString)
                    } catch {
                        completion(nil, "decoding error", status, urlRequest.url?.absoluteString)
                    }
                } else {
                    let error = MobiusError(rawValue: status) ?? MobiusError.Generic
                    completion(nil, error.getMessage(), status, urlRequest.url?.absoluteString)
                }
            }
        }
        task.resume()
    }
    
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
