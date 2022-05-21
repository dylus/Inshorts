//
//  NewsService.swift
//  Inshorts
//
//  Created by Michal Dylka on 21/05/2022.
//

import Foundation
import Combine

protocol NewsServiceProtocol {
    func requestNews(endpoint: Endpoint) -> AnyPublisher<News, APIError>
}

struct NewsService: NewsServiceProtocol {
    func requestNews(endpoint: Endpoint) -> AnyPublisher<News, APIError> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601

        return URLSession.shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<News, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .unknown).eraseToAnyPublisher()
                }

                guard (200...299).contains(response.statusCode) else {
                    return Fail(error: .code(response.statusCode)).eraseToAnyPublisher()
                }

                return Just(data)
                    .decode(type: News.self, decoder: jsonDecoder)
                    .mapError {_ in .decoding}
                    .eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
}
