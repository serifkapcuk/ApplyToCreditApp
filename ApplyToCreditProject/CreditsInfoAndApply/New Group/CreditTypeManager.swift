//
//  selectedCreditType.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 23.07.2025.
//


final class CreditTypeManager{
    
    static let sharedCredit:CreditTypeManager? = CreditTypeManager()
    private init() {}
    
    var currentCreditType: Int!
}
