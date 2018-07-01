import UIKit

class EvaluateCreditCardViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet private weak var labelCardBrand: UILabel!
    @IBOutlet private weak var labelCardStatus: UILabel!
    @IBOutlet private weak var labelCardNumber: UILabel!
    @IBOutlet private weak var textFieldInput: UITextField!
    
    // MARK: Properties
    
    private let presenter = EvaluateCreditCardPresenter()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
    }
    
    // MARK: Actions
    
    @IBAction private func buttonEvaluateTouched(_ sender: UIButton) {
        guard let input = textFieldInput.text else { return }
        presenter.evaluateInput(input)
        view.endEditing(true)
    }
}

extension EvaluateCreditCardViewController: EvaluateCreditCardView {
    func setCardBrand(_ brand: String) {
        labelCardBrand.text = brand
    }
    
    func setInputFieldText(_ text: String) {
        textFieldInput.text = text
    }
    
    func setCardNumberText(_ text: String) {
        labelCardNumber.text = text
    }
    
    func setCardValidationText(_ text: String) {
        labelCardStatus.text = text
    }
    
    func displayErrorMessage(_ message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
