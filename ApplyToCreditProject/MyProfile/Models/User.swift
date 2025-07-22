//
//  User.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 22.07.2025.
//
import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let lastname: String
    let identityNo: String
    let birthDay: String
    let phone: String
    let workType: Int
    let email: String
}
