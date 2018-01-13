import Foundation

public protocol APIRequest: Encodable {

	/// Endpoint for this request (the last part of the URL)
	var resourceName: String { get }
}
