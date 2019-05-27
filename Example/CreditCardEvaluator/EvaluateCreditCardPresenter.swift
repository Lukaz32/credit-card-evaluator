import CreditCardEvaluator

class EvaluateCreditCardPresenter {
    
    // MARK: Properties
    
    private weak var view: EvaluateCreditCardView?
    private let interactor: EvaluateCreditCardInteraction
    
    // MARK: Initialization
    
    init(interactor: EvaluateCreditCardInteraction = EvaluateCreditCardInteractor()) {
        self.interactor = interactor
    }

    // MARK: Private API
    
    private func clearAllFields() {
        view?.setCardBrandImage(nil)
        view?.setCardNumberText("")
        view?.setCardBrandText("")
    }
}

// MARK: - EvaluateCreditCardPresentation

extension EvaluateCreditCardPresenter: EvaluateCreditCardPresentation {
    
    func attachView(_ view: EvaluateCreditCardView) {
        self.view = view
    }
    
    func evaluateSelected(with input: String) {
        switch interactor.validateInput(input) {
        case .success(let card):
            view?.setCardValidationText("Card number is valid")
            view?.setCardBrandText(card.brandName)
            view?.setCardNumberText(card.number)
            view?.setInputFieldText("")
            view?.setCardBrandImage(card.icon)
        case .failure(let error):
            view?.setCardValidationText("Card number is not valid")
            view?.displayErrorMessage(error.localizedDescription, title: "Evaluation Error")
            clearAllFields()
        }
    }
}
