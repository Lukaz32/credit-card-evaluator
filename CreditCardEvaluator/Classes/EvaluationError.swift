import Foundation

public enum EvaluationError: Error {
    case numberIsInvalid
    case numberIsTooShort
    case numberIsTooLong
    case invalidCharacters
}

extension EvaluationError: LocalizedError {
    
    public var localizedDescription: String {
        switch self {
        case .numberIsInvalid:
            return "The number is not valid."
        case .numberIsTooShort:
            return "The number is too short."
        case .numberIsTooLong:
            return "The number is too long."
        case .invalidCharacters:
            return "The number contains invalid characters."
        }
    }
}
