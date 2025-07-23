import Foundation

protocol CreditApplicationViewModelDelegate: AnyObject {
    func applicationSucceeded()
    func applicationFailed(error: Error)
}

final class CreditsInfoAndApplyViewModel {
    
    weak var delegate: CreditApplicationViewModelDelegate?
    let baseUrl = "https://6075d8e5012c.ngrok-free.app/api"
    
    func applyForCredit(userId: Int, creditId: Int, loanAmount: Int, monthlySalary: Int) {
        guard let url = URL(string: "\(baseUrl)/creditswithuser/Create") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let application = CreditApplyRequest(
            userId: userId,
            creditId: creditId,
            loanAmount: loanAmount,
            monthlySalary: monthlySalary
        )
        
        do {
            request.httpBody = try JSONEncoder().encode(application)
        } catch {
            delegate?.applicationFailed(error: error)
            return
        }

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.delegate?.applicationFailed(error: error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.delegate?.applicationFailed(error: URLError(.badServerResponse))
                }
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(CreditApplicationResponse.self, from: data)

                print("Response geldi:")
                print("UserId: \(decodedResponse.userId ?? -1)")
                print("CreditId: \(decodedResponse.creditId ?? -1)")
                print("isApproved: \(decodedResponse.isApproved)")
                print("isApplied: \(decodedResponse.isApplied)")

                DispatchQueue.main.async {
                    if decodedResponse.isApplied {
                        self?.delegate?.applicationSucceeded()
                    } else {
                        let error = NSError(
                            domain: "",
                            code: 0,
                            userInfo: [NSLocalizedDescriptionKey: "Başvuru alınamadı."]
                        )
                        self?.delegate?.applicationFailed(error: error)
                    }
                }
            } catch {
                print("❌ JSON parse hatası: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.delegate?.applicationFailed(error: error)
                }
            }
        }.resume()
    }
}
