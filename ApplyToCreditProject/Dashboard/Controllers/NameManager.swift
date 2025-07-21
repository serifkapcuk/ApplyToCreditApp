//
//  NameManager.swift
//  ApplyToCreditProject
//
//  Created by Şerif Botan Kapcuk on 21.07.2025.
//



final class NameManager {
    
    static let sharedName:NameManager? = NameManager()
    private init() {}
    
    var currentUserName: String!
}
