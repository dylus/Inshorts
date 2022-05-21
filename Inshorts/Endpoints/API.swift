//
//  API.swift
//  Inshorts
//
//  Created by Michal Dylka on 21/05/2022.
//

import Foundation

protocol Builder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}

enum Endpoint: String, CaseIterable {
    case all
    case national
    case business
    case sports
    case world
    case politics
    case technology
    case startup
    case entertainment
    case miscellaneous
    case hatke
    case science
    case automobile

    var category: String {
        "category"
    }
}

extension Endpoint: Builder {
    var urlRequest: URLRequest {
        URLRequest(url: baseUrl.appendingPathComponent(path))
    }

    var baseUrl: URL {
        let queryItems = [URLQueryItem(name: category, value: rawValue)]
        var urlComponents = URLComponents(string: "https://inshorts.deta.dev/")
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url! else {
            fatalError(#function + "Base URL invalid")
        }

        return url
    }

    var path: String {
        "news"
    }
}
