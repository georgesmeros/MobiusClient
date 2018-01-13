import Foundation

struct GetBalance: APIRequest {
	public typealias Response = MobiusBalance

	public var resourceName: String {
		return "app_store/balance"
	}

	// Parameters
	public let email: String?
	public let app_uid: String?

	public init(email: String? = nil,
	            app_uid: String? = nil) {
		self.email = email
		self.app_uid = app_uid
	}
}
