//
//  NewsServiceMock.swift
//  InshortsTests
//
//  Created by Michal Dylka on 21/05/2022.
//

import Foundation
import Combine
@testable import Inshorts

final class NewsServiceMock: NewsServiceProtocol {
    var newsPublisher = PassthroughSubject<News, APIError>()
    var requestNewsCalled = [Bool]()
    func requestNews(endpoint: Endpoint) -> AnyPublisher<News, APIError> {
        requestNewsCalled.append(true)
        return newsPublisher.eraseToAnyPublisher()
    }
}
