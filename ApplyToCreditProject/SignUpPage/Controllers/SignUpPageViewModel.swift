//
//  SignUpPageViewModel.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 21.07.2025.
//
import UIKit

protocol RegisterPageViewModelInterface: AnyObject {
    func registerSucceeded(token: String)
    func registerFailed(error: Error)
}
final class SignUpPageViewModel: UIViewController {
    
    weak var delegate: RegisterPageViewModelInterface?
    let baseUrl = "https://6075d8e5012c.ngrok-free.app/api"
    
    func register(name: String,
                  surname: String,
                  birthday: String,
                  identityNo:String,
                  phone:String,
                  worktype:Int,
                  email:String,
                  password:String){
        guard let url = URL(string: "\(baseUrl)\(EndpointCategory.account.rawValue)\(Endpoints.register.rawValue)") else {
            delegate?.registerFailed(error: URLError(.badURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let newuser = UserRegistrationRequest(
            name: name,
            lastName: surname,
            identityNo: identityNo,
            birthDay: birthday,
            phone: phone,
            workType: worktype,
            email: email,
            password: password)
        do {
                  request.httpBody = try JSONEncoder().encode(newuser)
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                        if let error = error {
                            self?.delegate?.registerFailed(error: error)
                            return
                        }
                        guard let data = data else {
                            let err = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sunucudan boş yanıt"])
                            self?.delegate?.registerFailed(error: err)
                            return
                        }
                        do {
                            let resp = try JSONDecoder().decode(RegisterResponse.self, from: data)
                            DispatchQueue.main.async {
                                self?.delegate?.registerSucceeded(token: resp.token)
                            }
                        } catch {
                            self?.delegate?.registerFailed(error: error)
                        }
                    }.resume()
              } catch {
                  delegate?.registerFailed(error: error)
                  return
              }
    
            }
        }

