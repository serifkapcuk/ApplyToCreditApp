//
//  CreditsInfoAndApplyViewController.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 22.07.2025.
//

import UIKit

class CreditsInfoAndApplyViewController: UIViewController {
    
    @IBOutlet weak var creditAmountTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    
    private let viewModel = CreditsInfoAndApplyViewModel()
    var selectedCreditId: Int = CreditTypeManager.sharedCredit?.currentCreditType ?? 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    @IBAction func applyButtonTapped(_ sender: UIButton) {
        guard let userId = UserManager.shared.userID,
              let loanText = creditAmountTextField.text, let loanAmount = Int(loanText),
              let salaryText = salaryTextField.text, let salary = Int(salaryText)
        else {
            print("Lütfen geçerli değerler girin.")
            return
        }
        
        viewModel.applyForCredit(
            userId: userId,
            creditId: selectedCreditId,
            loanAmount: loanAmount,
            monthlySalary: salary
        )
    }
}
extension CreditsInfoAndApplyViewController: CreditApplicationViewModelDelegate {
    func applicationSucceeded() {
        print("Başvuru başarılı!")
    }
    
    func applicationFailed(error: Error) {
        print("Başvuru başarısız: \(error.localizedDescription)")
    }
}

