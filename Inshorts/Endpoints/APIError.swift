//
//  APIError.swift
//  Inshorts
//
//  Created by Michal Dylka on 21/05/2022.
//

import Foundation

enum APIError: Error {
    case decoding
    case code(Int)
    case unknown
}

extension APIError: LocalizedError {
    public var description: String? {
        switch self {
        case .decoding:
            return "Decode Error"
        case .code(let code):
            return "\(code) - Error code"
        case .unknown:
            return "Unknown error"
        }
    }
}
