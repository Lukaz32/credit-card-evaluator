import CreditCardEvaluator

class EvaluateCreditCardInteractor: EvaluateCreditCardInteraction {
    
    func validateInput(_ input: String) -> Result<Card, EvaluateCardError> {
        do {
            let (isValid, brand) = try CreditCardEvaluator.isCardNumberValid(input)
            guard isValid else {
                return .failure(.invalidCard("Unexpected error."))
            }
            return .success(Card(brandName: brand.name, number: input, icon: icon(for: brand)))
        } catch let error as EvaluationError {
            return .failure(.invalidCard(error.localizedDescription))
        } catch {
            return .failure(.invalidCard("Unexpected error."))
        }
    }
    
    // MARK: Private API
    
    private func icon(for brand: CreditCardEvaluator.CardBrand) -> UIImage? {
        switch brand {
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
