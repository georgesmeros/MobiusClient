import Foundation

/// Mobius API Client
public class MobiusAPIClient {
	private let baseURLEndpoint = "https://mobius.network/api/v1/"
	private let session = URLSession(configuration: .default)
	private let api_key: String

	public init(apiKey: String) {
		self.api_key = apiKey
	}
    
    public func getBalance(_ app_uid: String? = nil,_ email: String? = nil, _ completion: @escaping (MobiusBalance?, String?) -> Void) {
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
                                completion(nil, "decoding error")
                                return
                        }
                        completion(MobiusBalance.fromJSON(json: json), nil)
                    } catch {
                        completion(nil, "decoding error")
                    }
                } else {
                    let error = MobiusError(rawValue: status) ?? MobiusError.Generic
                    completion(nil, error.getMessage())
                }
            }
		}
		task.resume()
	}
    
    public func useCredit(app_uid: Int, email: String, numCredits: Double, completion: @escaping (MobiusBalance?, String?) -> Void) {
        let request = UseCredits.init(app_uid: app_uid, email: email, numCredits: numCredits)
        
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
                                completion(nil, "decoding error")
                                return
                        }
                        completion(MobiusBalance.fromJSON(json: json), nil)
                    } catch {
                        completion(nil, "decoding error")
                    }
                } else {
                    let error = MobiusError(rawValue: status) ?? MobiusError.Generic
                    completion(nil, error.getMessage())
                }
            }
        }
        task.resume()
    }

	/// Encodes a URL based on the given request
	/// Everything needed for a public request to Marvel servers is encoded directly in this URL
	private func endpoint<T: APIRequest>(for request: T) -> URL {
		guard let parameters = try? URLQueryEncoder.encode(request) else { fatalError("Wrong parameters") }

		// Construct the final URL with all the previous data
		return URL(string: "\(baseURLEndpoint)\(request.resourceName)?api_key=\(api_key)&\(parameters)")!
	}
}
