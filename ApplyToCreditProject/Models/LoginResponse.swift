//
//  LoginResponse.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 17.07.2025.
//


import Foundation

struct LoginResponse: Codable {
    var token: String
    var name: String
    var lastname: String
}
