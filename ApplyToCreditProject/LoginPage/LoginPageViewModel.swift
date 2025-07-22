//
//  LoginPageViewModel.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 16.07.2025.
//

import Foundation
import UIKit



protocol LoginPageViewModelInterface {
    func loginSucceeded(token: String)
    func loginSucceeded(name: String)
    func loginSucceeded(user: User)
    func loginFailed(error: Error)
}

final class LoginPageViewModel {
    var delegate: LoginPageViewModelInterface?
    
    let baseUrl = "https://6075d8e5012c.ngrok-free.app/api"
    
    func login(identityNo:String, password:String) {
        guard let url = URL(string: "\(baseUrl)\(EndpointCategory.account.rawValue)\(Endpoints.login.rawValue)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginData = LoginPage(identityNo: identityNo, password: password)
        
        do {
            request.httpBody = try JSONEncoder().encode(loginData)
        } catch {
            delegate?.loginFailed(error: error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                self?.delegate?.loginFailed(error: error)
                return
            }
            
            guard let data = data else {
                self?.delegate?.loginFailed(error: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Veri Boş"]))
                return
            }
            
            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.delegate?.loginSucceeded(token: loginResponse.token)
                    self?.delegate?.loginSucceeded(name: loginResponse.name)
                }
            } catch {
                self?.delegate?.loginFailed(error: error)
            }
        }.resume()
    }
}
