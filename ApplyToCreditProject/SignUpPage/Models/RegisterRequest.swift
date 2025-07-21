//
//  Register.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 21.07.2025.
//

	
import Foundation

struct UserRegistrationRequest: Codable {
    let name: String
    let lastName: String
    let identityNo: String
    let birthDay: String
    let phone: String
    let workType: Int
    let email: String
    let password: String
}
