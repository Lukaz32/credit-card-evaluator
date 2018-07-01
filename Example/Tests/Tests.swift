import Quick
import Nimble
import CreditCardEvaluator

class CreditCardEvaluatorSpec: QuickSpec {
    override func spec() {
        
        describe("Invalid input use cases") {
            
            var inputNumber: String!

            context("when a number with a leading ZERO is provided") {
                beforeEach {
                    inputNumber = "0929804463622138"
                }
                
                it("should throw a numberIsInvalid exception") {
                    expect { try CreditCardEvaluator.isCardNumberValid(inputNumber) }
                        .to(throwError(CreditCardEvaluator.EvaluationError.numberIsInvalid))
                }
            }
            
            context("when an 11 digits number is provided") {
                beforeEach {
                    inputNumber = "14463622138"
                }
                
                it("should throw a numberIsTooShort exception") {
                    expect { try CreditCardEvaluator.isCardNumberValid(inputNumber) }
                        .to(throwError(CreditCardEvaluator.EvaluationError.numberIsTooShort))
                }
            }
            
            context("when a 20 digits number is provided") {
                beforeEach {
                    inputNumber = "49298044636221380000"
                }
                
                it("should throw a numberIsTooLong exception") {
                    expect { try CreditCardEvaluator.isCardNumberValid(inputNumber) }
                        .to(throwError(CreditCardEvaluator.EvaluationError.numberIsTooLong))
                }
            }
            
            context("when an INVALID VISA number is provided") {
                beforeEach {
                    inputNumber = "4929804463622138"
                }
                
                it("should be evaluated as INVALID") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).isValid).to(beFalse())
                }
                
                it("should be evaluated as VISA") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).brand).to(equal(CreditCardEvaluator.CardBrand.visa))
                }
            }
            
            context("when an INVALID MASTERCARD number is provided") {
                beforeEach {
                    inputNumber = "5212132012291762"
                }
                
                it("should be evaluated as INVALID") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).isValid).to(beFalse())
                }
                
                it("should be evaluated as MASTERCARD") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).brand).to(equal(CreditCardEvaluator.CardBrand.mastercard))
                }
            }
            
            context("when an INVALID MAESTRO number is provided") {
                beforeEach {
                    inputNumber = "6762765696545486"
                }
                
                it("should be evaluated as INVALID") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).isValid).to(beFalse())
                }
                
                it("should be evaluated as MAESTRO") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).brand).to(equal(CreditCardEvaluator.CardBrand.maestro))
                }
            }
            
            context("when an INVALID CHINA UNION PAY number is provided") {
                beforeEach {
                    inputNumber = "6210948000000028"
                }
                
                it("should be evaluated as INVALID") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).isValid).to(beFalse())
                }
                
                it("should be evaluated as CHINA UNION PAY") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).brand).to(equal(CreditCardEvaluator.CardBrand.chinaUnionPay))
                }
            }
            
        }
        
        describe("Valid input use cases") {
            
            var inputNumber: String!
            
            context("when a VALID VISA number is provided") {
                beforeEach {
                    inputNumber = "4929804463622139"
                }
                
                it("should be evaluated as VALID") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).isValid).to(beTrue())
                }
                
                it("should be evaluated as VISA") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).brand).to(equal(CreditCardEvaluator.CardBrand.visa))
                }
            }
            
            context("when a VALID MASTERCARD number is provided") {
                beforeEach {
                    inputNumber = "5212132012291765"
                }
                
                it("should be evaluated as VALID") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).isValid).to(beTrue())
                }
                
                it("should be evaluated as MASTERCARD") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).brand).to(equal(CreditCardEvaluator.CardBrand.mastercard))
                }
            }
            
            context("when a VALID MAESTRO number is provided") {
                beforeEach {
                    inputNumber = "6762765696545485"
                }
                
                it("should be evaluated as VALID") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).isValid).to(beTrue())
                }
                
                it("should be evaluated as MAESTRO") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).brand).to(equal(CreditCardEvaluator.CardBrand.maestro))
                }
            }
            
            context("when a VALID CHINA UNION PAY number is provided") {
                beforeEach {
                    inputNumber = "6210948000000029"
                }
                
                it("should be evaluated as VALID") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).isValid).to(beTrue())
                }
                
                it("should be evaluated as CHINA UNION PAY") {
                    expect(try? CreditCardEvaluator.isCardNumberValid(inputNumber).brand).to(equal(CreditCardEvaluator.CardBrand.chinaUnionPay))
                }
            }
            
        }
    }
}
