//
//  showthecredit.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 25.07.2025.
//

import Foundation

struct UserCreditStatus: Codable {
    let userId: Int
    let creditsName: [String]
    let creditAppliedDate: [String]
    let isApplied: [Bool]
    let isApproved: [Bool]
}
