import Foundation

public struct UseCredits: APIRequest {
	public typealias Response = MobiusBalance

	// Notice how we create a composed resourceName
	public var resourceName: String {
		return "app_store/use"
	}

	// Parameters
	private let app_uid: Int?
    private let email: String?
    private let numCredits: Double?

    public init(app_uid: Int? = nil, email: String? = nil, numCredits: Double? = nil) {
		self.app_uid = app_uid
        self.email = email
        self.numCredits = numCredits
	}
}
