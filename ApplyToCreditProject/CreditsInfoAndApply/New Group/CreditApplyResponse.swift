//
//  CreditApplyR.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 23.07.2025.
//


struct CreditApplicationResponse: Codable {
    let userId:Int?
    let creditId:Int?
    let isApproved:Bool
    let creditName:String?
    let isApplied:Bool
}


