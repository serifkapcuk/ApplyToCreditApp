//
//  myProfileViewModel.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 22.07.2025.
//



import Foundation

protocol ProfileViewModelInterface: AnyObject {
    func getUser(_ user: User)
    func getUserFailed(with error: Error)
}

final class ProfileViewModel {
    weak var delegate: ProfileViewModelInterface?
    
    private let baseURL = "https://6075d8e5012c.ngrok-free.app/api"
    
    func fetchUser(withId id: Int) {
        guard let url = URL(string: "\(baseURL)/users/\(id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.delegate?.getUserFailed(with: error)
                }
                return
            }
            
            guard let data = data else { return }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    self?.delegate?.getUser(user)
                }
            } catch {
                DispatchQueue.main.async {
                    self?.delegate?.getUserFailed(with: error)
                }
            }
        }.resume()
    }
}
