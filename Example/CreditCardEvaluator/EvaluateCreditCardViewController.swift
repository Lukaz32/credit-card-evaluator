import UIKit

class EvaluateCreditCardViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet private weak var labelCardBrand: UILabel!
    @IBOutlet private weak var labelCardStatus: UILabel!
    @IBOutlet private weak var labelCardNumber: UILabel!
    @IBOutlet private weak var textFieldInput: UITextField!
    @IBOutlet private weak var imageViewCardBrand: UIImageView!
    
    // MARK: Properties
    
    private let presenter: EvaluateCreditCardPresentation
    
    init(presenter: EvaluateCreditCardPresentation = EvaluateCreditCardPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
    }
    
    // MARK: Actions
    
    @IBAction private func buttonEvaluateTouched(_ sender: UIButton) {
        guard let input = textFieldInput.text else { return }
        presenter.evaluateSelected(with: input)
        view.endEditing(true)
    }
}

// MARK: - EvaluateCreditCardView

extension EvaluateCreditCardViewController: EvaluateCreditCardView {
    func setCardBrandText(_ text: String) {
        labelCardBrand.text = text
    }
    
    func setInputFieldText(_ text: String) {
        textFieldInput.text = text
    }
    
    func setCardNumberText(_ text: String) {
        labelCardNumber.text = text
    }
    
    func setCardBrandImage(_ image: UIImage?) {
        imageViewCardBrand.image = image
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
