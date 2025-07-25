//
//  MyProfileViewController.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 22.07.2025.
//

import UIKit

class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var backToButton: UIButton!
    @IBOutlet weak var shutDownButton: UIButton!
    @IBOutlet weak var creditsStackView: UIStackView!

    
    private let viewModel = ProfileViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        getUserId()
        if let userId = UserManager.shared.userID {
               viewModel.fetchUser(withId: userId)
               viewModel.fetchCredits(forUser: userId)
           }
    }
    
   
    func displayCredits(_ creditStatus: UserCreditStatus) {
        DispatchQueue.main.async {
            self.creditsStackView.axis = .vertical
            self.creditsStackView.spacing = 10
            self.creditsStackView.distribution = .fillEqually
            self.creditsStackView.alignment = .fill
            self.creditsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            
            for (index, creditName) in creditStatus.creditsName.enumerated() {
                let isApproved = creditStatus.isApproved[index]
                let statusText = isApproved ? "Onaylandı" : "Reddedildi"
                
                let button = UIButton(type: .system)
                button.setTitle("\(creditName) - \(statusText)", for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = isApproved ? .systemGreen : .systemRed
                button.layer.cornerRadius = 10
                button.heightAnchor.constraint(equalToConstant: 50).isActive = true
                
                self.creditsStackView.addArrangedSubview(button)
            }
        }
    }
    
    
    func getUserId() {
        if let userID = UserManager.shared.userID {
            print("Kullanıcı ID: \(userID)")
            viewModel.fetchUser(withId: userID)
        } else {
            print("Kullanıcı ID bulunamadı.")
        }
    }
    
    @IBAction func backTuButtonClicked(_ sender:UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "dashboardID")
        nextVC.modalPresentationStyle = .custom
        self.present(nextVC, animated: true, completion: nil)
    }
    @IBAction func shutDownButtonClicked(_ sender:UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "homePageID")
        nextVC.modalPresentationStyle = .custom
        self.present(nextVC, animated: true, completion: nil)
        
    }
    
}
extension MyProfileViewController: ProfileViewModelInterface {
    func getCredits(_ credits: UserCreditStatus) {
        displayCredits(credits)

    }
    
    func getCreditsFailed(with error: any Error) {
        print("Credits fetch error: \(error.localizedDescription)")

    }
    
    
    func getUser(_ user: User) {
        nameLabel.text = "\(user.name) \(user.lastname)"
        phoneLabel.text = user.phone
        emailLabel.text = user.email
    }
    
    func getUserFailed(with error: Error) {
        print("Kullanıcı alınamadı: \(error.localizedDescription)")
    }
}
