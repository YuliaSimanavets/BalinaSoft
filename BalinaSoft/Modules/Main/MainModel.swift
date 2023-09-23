//
//  MainModel.swift
//  BalinaSoft
//
//  Created by Yuliya on 23/09/2023.
//

import Foundation

// MARK: - Main
struct Main: Codable {
    let content: [Content]
}

// MARK: - Content
struct Content: Codable {
    let id: Int
    let name: String
    let image: String?
}
