//
//  CreditApplyRequest.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 23.07.2025.
//

import Foundation

struct CreditApplyRequest : Codable {
    let userId: Int?
    let creditId: Int?
    let loanAmount: Int?
    let monthlySalary: Int?
}
