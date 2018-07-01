import CreditCardEvaluator

protocol EvaluateCreditCardView: class {
    func setCardBrand(_ brand: String)
    func setInputFieldText(_ text: String)
    func setCardNumberText(_ text: String)
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
            view?.setCardBrand(brand.rawValue)
            view?.setCardNumberText(input)
            view?.setInputFieldText("")
        } catch let error as EvaluationError {
            view?.displayErrorMessage(error.localizedDescription, title: "Evaluation Error")
        } catch {
            view?.displayErrorMessage("Unexpected error", title: "Evaluation Error")
        }
    }
    
}
