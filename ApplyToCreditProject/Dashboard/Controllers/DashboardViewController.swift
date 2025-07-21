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
    
    func getTitleName() {
        if let name = NameManager.sharedName?.currentUserName {
            headerText.text = "HOŞGELDİN , \(name)!"
        }
        
    }
    
    func createButtonsDynamically(from credits: [CreditTypes]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for credit in credits {
            let button = UIButton(type: .system)
            button.setTitle(credit.creditName, for: .normal)            
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            button.backgroundColor = .black
            button.tintColor = .white
            button.layer.cornerRadius = 10
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            button.tag = credit.id ?? 0
            button.addTarget(self, action: #selector(creditButtonTapped(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
        }
    }
    @objc func creditButtonTapped(_ sender: UIButton) {
        let selectedId = sender.tag
        print("Butona tıklandı, kredi ID: \(selectedId)")
    }
    
}

