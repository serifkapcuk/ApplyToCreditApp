//
//  LoginViewController.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 16.07.2025.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    
    let viewModel = LoginPageViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
        
    }
    
    func setupUI(){
        userNumberTextField.backgroundColor = .white
        passwordTextField.backgroundColor = .white
        userNumberTextField.tintColor = .black
        passwordTextField.tintColor = .black
        userNumberTextField.textColor = .black
        passwordTextField.textColor = .black
        
        userNumberTextField.attributedPlaceholder = NSAttributedString(
            string: "T.C. Kimlik veya Müşteri Numarası",
            attributes: [.foregroundColor: UIColor.black]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Dijital Şifreniz",
            attributes: [.foregroundColor: UIColor.black]
        )
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "homePageID")
        nextVC.modalPresentationStyle = .custom
        self.present(nextVC, animated: true, completion: nil)
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let identity =  userNumberTextField.text,
              let password = passwordTextField.text else { return }
        
        viewModel.login(identityNo: identity, password: password)
    }
}

extension LoginViewController: LoginPageViewModelInterface {
    func loginSucceeded(token: String) {
            print("Giriş başarılı! Token: \(token)")
    }
    
    func loginFailed(error: Error) {
            print("Giriş başarısız: \(error.localizedDescription)")
    }
}

