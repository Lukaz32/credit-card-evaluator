import Foundation

public struct CreditCardEvaluator {
    
    public enum CardBrand: String {
        case visa = "Visa"
        case mastercard = "Mastercard"
        case maestro = "Maestro"
        case chinaUnionPay = "China Union Pay"
        case unknown = "Unknown"
        
        public var name: String {
            return self.rawValue
        }
    }
    
    public typealias CardEvaluation = (isValid: Bool, brand: CardBrand)
    typealias EError = EvaluationError
    
    // MARK: Public API
    
    public static func isCardNumberValid(_ input: String) throws -> CardEvaluation {
        guard CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: input)) else { throw EError.invalidCharacters }
        guard !input.isEmpty, input.first != "0" else { throw EError.numberIsInvalid }
        guard input.count >= 12  else { throw EError.numberIsTooShort }
        guard input.count <= 19 else { throw EError.numberIsTooLong }
        return (luhnsAlgorithmChek(input), cardBrand(input))
    }
    
    // MARK: Private API
    
    private static func luhnsAlgorithmChek( _ input: String) -> Bool {
        let input = input.reversed().map { String($0) }
        
        var totalSum = 0
        
        input.enumerated().forEach { offset, char in
            
            guard let number = Int(char) else { return }
            
            switch (offset.isOdd, number) {
            case (true, 9):
                totalSum += 9
            case (true, 0...8):
                totalSum += (number * 2) % 9
            default:
                totalSum += number
            }
        }
        
        return totalSum % 10 == 0
    }
    
    private static func cardBrand(_ input: String) -> CardBrand {
        guard let firstSixDigits = Int(input.prefix(6)) else { return .unknown }
        
        switch firstSixDigits {
        case 400000...499999:
            return .visa
        case 222100...272099, 510000...559999:
            return .mastercard
        case 620000...629999:
            return .chinaUnionPay
        case 500000...509999, 560000...699999:
            return .maestro
        default:
            return .unknown
        }
    }
    
}
