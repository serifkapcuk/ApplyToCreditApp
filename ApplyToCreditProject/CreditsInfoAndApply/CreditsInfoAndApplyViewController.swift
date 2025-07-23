//
//  CreditsInfoAndApplyViewController.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 22.07.2025.
//

import UIKit

final class CreditsInfoAndApplyViewController: UIViewController {
    
    @IBOutlet weak var creditAmountTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var backButton:UIButton!
    
    private let viewModel = CreditsInfoAndApplyViewModel()
    var selectedCreditId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
    }
    func setupUI() {
        creditAmountTextField.attributedPlaceholder = NSAttributedString(
            string: "Talep Ettiğiniz Kredi Tutarını Giriniz",
            attributes: [.foregroundColor: UIColor.black]
        )
        salaryTextField.attributedPlaceholder = NSAttributedString(
            string: "Maaşınızı Giriniz",
            attributes: [.foregroundColor: UIColor.black]
        )
        creditAmountTextField.textColor = .black
        salaryTextField.textColor = .black
        creditAmountTextField.backgroundColor = .white
        salaryTextField.backgroundColor = .white
        creditAmountTextField.tintColor = .black
        salaryTextField.tintColor = .black
    }
    
    @IBAction func clickedBackButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "dashboardID")
        nextVC.modalPresentationStyle = .custom
        self.present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func applyButtonTapped(_ sender: UIButton) {
        guard let userId = UserManager.shared.userID,
              let loanText = creditAmountTextField.text,
              let loanAmount = Int(loanText),
              let salaryText = salaryTextField.text,
              let salary = Int(salaryText)
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
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: "TEBRİKLER!", message:"Başvurunuz başarı ile alınmıştır.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { _ in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let nextVC = storyboard.instantiateViewController(withIdentifier: "resultID")
                nextVC.modalPresentationStyle = .custom
                self.present(nextVC, animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
       
        
    }
    
    func applicationFailed(error: Error) {
        print("Başvuru başarısız: \(error.localizedDescription)")
    }
    
}
