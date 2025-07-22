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
    
    private let viewModel = ProfileViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        getUserId()
        
        
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
    
    func getUser(_ user: User) {
        nameLabel.text = "\(user.name) \(user.lastname)"
        phoneLabel.text = user.phone
        emailLabel.text = user.email
    }
    
    func getUserFailed(with error: Error) {
        print("Kullanıcı alınamadı: \(error.localizedDescription)")
    }
}
