//
//  SignUpPageViewController.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 21.07.2025.
//



import UIKit

class SignUpPageViewController: UIViewController {
   
 
    @IBOutlet var sigUpButton: UIButton!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var tcKimlikNoTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var workingSituationTextField: UITextField!
    @IBOutlet weak var telephoneNumberTextField: UITextField!
    
   
    private let viewModel = SignUpPageViewModel()
    private let datePicker = UIDatePicker()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
        configureDatePicker()
        setupPasswordToggle()
        setup2PasswordToggle()
    }

    func setupUI(){
        
        nameTextField.backgroundColor = .white
        birthdayTextField.backgroundColor = .white
        surnameTextField.backgroundColor = .white
        passwordTextField.backgroundColor = .white
        emailAddressTextField.backgroundColor = .white
        telephoneNumberTextField.backgroundColor = .white
        workingSituationTextField.backgroundColor = .white
        repeatPasswordTextField.backgroundColor = .white
        tcKimlikNoTextField.backgroundColor = .white
        
        nameTextField.textColor = .black
        birthdayTextField.textColor  = .black
        surnameTextField.textColor  = .black
        passwordTextField.textColor = .black
        emailAddressTextField.textColor = .black
        telephoneNumberTextField.textColor = .black
        workingSituationTextField.textColor = .black
        repeatPasswordTextField.textColor  = .black
        tcKimlikNoTextField.textColor  = .black
        
        nameTextField.tintColor = .black
        birthdayTextField.tintColor = .black
        surnameTextField.tintColor = .black
        passwordTextField.tintColor = .black
        emailAddressTextField.tintColor = .black
        telephoneNumberTextField.tintColor = .black
        workingSituationTextField.tintColor = .black
        repeatPasswordTextField.tintColor = .black
        tcKimlikNoTextField.tintColor = .black
        passwordTextField.isSecureTextEntry = true
        repeatPasswordTextField.isSecureTextEntry = true

        
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "İsim",
            attributes: [.foregroundColor: UIColor.black]
        )
        birthdayTextField.attributedPlaceholder = NSAttributedString(
            string: "Doğum Tarihi",
            attributes: [.foregroundColor: UIColor.black]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Parola",
            attributes: [.foregroundColor: UIColor.black]
        )
        surnameTextField.attributedPlaceholder = NSAttributedString(
            string: "Soyad",
            attributes: [.foregroundColor: UIColor.black]
        )
        emailAddressTextField.attributedPlaceholder = NSAttributedString(
            string: "E-mail Adresi",
            attributes: [.foregroundColor: UIColor.black]
        )
        telephoneNumberTextField.attributedPlaceholder = NSAttributedString(
            string: "Telefon Numarası",
            attributes: [.foregroundColor: UIColor.black]
        )
        workingSituationTextField.attributedPlaceholder = NSAttributedString(
            string: "Çalışma Durumu",
            attributes: [.foregroundColor: UIColor.black]
        )
        repeatPasswordTextField.attributedPlaceholder = NSAttributedString(
            string: "Parola Tekrarı",
            attributes: [.foregroundColor: UIColor.black]
        )
        tcKimlikNoTextField.attributedPlaceholder = NSAttributedString(
            string: "T.C. Kimlik Numarası",
            attributes: [.foregroundColor: UIColor.black]
        )
        
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
    
    func setup2PasswordToggle() {
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        eyeButton.addTarget(self, action: #selector(toggle2PasswordVisibility(_:)), for: .touchUpInside)
        
       repeatPasswordTextField.rightView = eyeButton
        repeatPasswordTextField.rightViewMode = .always
     
      
    }
    @objc func toggle2PasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    
    @IBAction func cancelButtonClicked() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "homePageID")
        nextVC.modalPresentationStyle = .custom
        self.present(nextVC, animated: true, completion: nil)
    }
    
    func configureDatePicker() {
        birthdayTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    @objc private func dateChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        birthdayTextField.text = formatter.string(from: datePicker.date)
    }
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard
            
            let name = nameTextField.text, !name.isEmpty,
            let lastName = surnameTextField.text, !lastName.isEmpty,
            let idNo =  tcKimlikNoTextField.text, !idNo.isEmpty,
            let birth = birthdayTextField.text, !birth.isEmpty,
            let phone = telephoneNumberTextField.text, !phone.isEmpty,
            let workTypeStr = workingSituationTextField.text, let workRaw = Int(workTypeStr),let workType = WorkType(rawValue: workRaw),
            let email = emailAddressTextField.text, !email.isEmpty,
            let pwd = passwordTextField.text, !pwd.isEmpty
        else {
            let alert = UIAlertController(title: "Hata", message:"Telefon Numaranızın Başında '0' olmadığından emin olun!Parolarınızın eşleştiğine emin olun! Parolanız 6 haneden fazla olamaz! ve Lütfen Tüm Boşlukları Doldurunuz!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        viewModel.register(
            name: name,
            surname: lastName,
            birthday: birth,
            identityNo: idNo,
            phone: phone,
            worktype: workType.rawValue,
            email: email,
            password: pwd
        )
    }
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true, completion: nil)
    }
}

extension SignUpPageViewController : RegisterPageViewModelInterface {
    func registerSucceeded(token: String) {
        TokenManager.shared.token = token
        print(" Kayıt başarılı! Token: \(TokenManager.shared.token)")

        DispatchQueue.main.async { [weak self] in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "dashboardID")
            nextVC.modalPresentationStyle = .custom
            self?.present(nextVC, animated: true, completion: nil)
        }
    }
    
    func registerFailed(error: Error) {
        DispatchQueue.main.async {
            self.showAlert(title: "Kayıt Başarısız", message: error.localizedDescription)
            
        }
    }
    
}

