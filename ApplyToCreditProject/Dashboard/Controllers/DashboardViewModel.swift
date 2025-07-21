//
//  DashboardViewModel.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 18.07.2025.
//


import UIKit

final class DashboardViewModel {
    
    let baseUrl = "https://6075d8e5012c.ngrok-free.app/api"
   
    func getCreditTypes(completion: @escaping ([CreditTypes]?) -> Void) {
        guard let url = URL(string: "\(baseUrl)\(EndpointCategory.credits.rawValue)\(Endpoints.getAllCredits.rawValue)") else { return }
        debugPrint(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("İstek hatası: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Veri yok")
                return
            }
            
            do {
                let decodedList = try JSONDecoder().decode([CreditTypes].self, from: data)
                completion(decodedList)
            } catch {
                print("Decode hatası: \(error)")
            }
        }.resume()
    }
}

