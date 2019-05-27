import UIKit

enum EvaluateCardError: Error {
    case invalidCard(String)
}

struct Card {
    let brandName: String
    let number: String
    let icon: UIImage?
}
