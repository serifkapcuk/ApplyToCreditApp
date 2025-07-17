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
    @IBOutlet weak var loginButton: UIButton!
    
    let viewModel = LoginPageViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
        setupPasswordToggle()
    }
    
    func setupPasswordToggle() {
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
    }
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
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
    
    func checkLimitedLoginPage(){
        if userNumberTextField.text?.count == 11 && passwordTextField.text?.count == 6 {
            loginButton.isUserInteractionEnabled = true
            loginButton.setImage(UIImage(named: "enabledLoginButton"), for: .normal)
            
        }
        else {
            loginButton.isUserInteractionEnabled = false
            loginButton.setImage(UIImage(named: "loginButton"), for: .normal)
        }
    }
    
    @IBAction func userNumberTextFieldEditing(_ sender: UITextField) {
        checkLimitedLoginPage()
    }
    
    @IBAction func passwordTextFieldEditing(_ sender: UITextField) {
        checkLimitedLoginPage()
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

