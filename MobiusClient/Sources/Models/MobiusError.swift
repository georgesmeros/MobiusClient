import Foundation

public enum MobiusError: Int {
    case BadRequest = 400
	case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
    case TooManyRequests = 429
    case InternalServerError = 500
	case ServiceUnavailable = 503
    case Generic = -1
    
    func getMessage() -> String {
        switch self {
        case .BadRequest:
            return "Parameters are incorrect"
        case .Unauthorized:
            return "Your API key is wrong"
        case .Forbidden:
            return "You do not have access"
        case .NotFound:
            return "Bad URL and/or HTTP Method"
        case .TooManyRequests:
            return "Too many requests, Slow down!"
        case .InternalServerError:
            return "We had a problem with our server. Try again and if it keeps happening email support@mobius.network"
        case .ServiceUnavailable:
            return "We're temporarily offline for maintenance. Please try again later."
        case .Generic:
            return "Something went wrong"
        }
    }
}
