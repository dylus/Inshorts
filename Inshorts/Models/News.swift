//
//  News.swift
//  Inshorts
//
//  Created by Michal Dylka on 21/05/2022.
//

import Foundation

// MARK: - News
struct News: Codable {
    let category: String?
    let articles: [Article]?
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case category
        case articles = "data"
        case success
    }
}

// MARK: - Article
struct Article: Codable {
    let author, content, date: String?
    let imageURL: String?
    let readMoreURL: String?
    let time, title: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author, content, date
        case imageURL = "imageUrl"
        case readMoreURL = "readMoreUrl"
        case time, title, url
    }
}
