import CreditCardEvaluator

protocol EvaluateCreditCardView: class {
    func setCardBrandText(_ text: String)
    func setInputFieldText(_ text: String)
    func setCardNumberText(_ text: String)
    func setCardBrandImage(_ image: UIImage?)
    func setCardValidationText(_ text: String)
    func displayErrorMessage(_ message: String, title: String)
}

class EvaluateCreditCardPresenter {
    
    // MARK: Properties
    
    private weak var view: EvaluateCreditCardView?
    
    // MARK: Public API
    
    func attachView(view: EvaluateCreditCardView) {
        self.view = view
    }
    
    func evaluateInput(_ input: String) {
        do {
            let (isValid, brand) = try CreditCardEvaluator.isCardNumberValid(input)
            view?.setCardValidationText(isValid ? "Card number is valid" : "Card number is not valid")
            view?.setCardBrandText(brand.rawValue)
            view?.setCardNumberText(input)
            view?.setInputFieldText("")
            view?.setCardBrandImage(brand.icon)
        } catch let error as EvaluationError {
            view?.displayErrorMessage(error.localizedDescription, title: "Evaluation Error")
            clearAllFields()
        } catch {
            view?.displayErrorMessage("Unexpected error", title: "Evaluation Error")
            clearAllFields()
        }
    }
    
    // MARK: Private API
    
    private func clearAllFields() {
        view?.setCardBrandImage(nil)
        view?.setCardNumberText("")
        view?.setCardBrandText("")
    }
}

private extension CreditCardEvaluator.CardBrand {
    var icon: UIImage? {
        switch self {
        case .visa:
            return #imageLiteral(resourceName: "visa")
        case .mastercard:
            return #imageLiteral(resourceName: "mastercard")
        case .maestro:
            return #imageLiteral(resourceName: "maestro")
        case .chinaUnionPay:
            return #imageLiteral(resourceName: "unionPay")
        case .unknown:
            return nil
        }
    }
}
