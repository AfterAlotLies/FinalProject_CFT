//
//  DataRepository.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 11.06.2024.
//

import Foundation

struct DataRepository: Codable {
    let title: String
    let price: Double
    let description: String
    let category: String
    let rating: Rating
    let image: String
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}

struct TokenData: Codable {
    let token: String
}
