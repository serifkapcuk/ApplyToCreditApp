//
//  DashboardViewController.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 18.07.2025.
//

import UIKit

class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var headerText: UILabel!
    
    let viewModel = DashboardViewModel()
    var creditItems: [CreditTypes] = []
    
    
    @IBOutlet var myProfileButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTitleName()
        viewModel.getCreditTypes { [weak self] creditTypesArray in
            guard let creditArray = creditTypesArray else { return }
            DispatchQueue.main.async {
                self?.createButtonsDynamically(from: creditArray)
            }
        }
        
        
    }
    @IBAction func profileButtonTapped()  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "myProfileID")
        nextVC.modalPresentationStyle = .custom
        self.present(nextVC, animated: true, completion: nil)
    }
    
    func getTitleName() {
        if let name = NameManager.sharedName?.currentUserName {
            headerText.text = "HOŞGELDİN , \(name)!"
            headerText.font = UIFont.boldSystemFont(ofSize: 24)
            headerText.textColor = .black
        }
        
    }
    
    func createButtonsDynamically(from credits: [CreditTypes]) {
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for credit in credits {
            
            let button = UIButton(type: .system)
            button.setTitle(credit.creditName, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            button.backgroundColor = .white
            button.tintColor = .black
            button.titleLabel?.textColor = .black
            button.layer.cornerRadius = 10
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            button.tag = credit.id ?? 0
            button.addTarget(self, action: #selector(creditButtonTapped(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
            //CreditTypeManager.sharedCredit?.currentCreditType = credit.id
        }
    }
    
    @objc func creditButtonTapped(_ sender: UIButton) {
        let selectedId = sender.tag
        print("Butona tıklandı, kredi ID: \(selectedId)")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "CreditDetailVC") as? CreditsInfoAndApplyViewController else { return }
        nextVC.selectedCreditId = selectedId
        nextVC.modalPresentationStyle = .custom
        self.present(nextVC, animated: true, completion: nil)
    }
    
}

