import UIKit

protocol EvaluateCreditCardInteraction: class {
    func validateInput(_ input: String) -> Result<Card, EvaluateCardError>
}

protocol EvaluateCreditCardPresentation: class {
    func attachView(_ view: EvaluateCreditCardView)
    func evaluateSelected(with input: String)
}

protocol EvaluateCreditCardView: class {
    func setCardBrandText(_ text: String)
    func setInputFieldText(_ text: String)
    func setCardNumberText(_ text: String)
    func setCardBrandImage(_ image: UIImage?)
    func setCardValidationText(_ text: String)
    func displayErrorMessage(_ message: String, title: String)
}
