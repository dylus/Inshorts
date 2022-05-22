//
//  HomeListViewModelTests.swift
//  InshortsTests
//
//  Created by Michal Dylka on 21/05/2022.
//

import XCTest
import Combine
@testable import Inshorts

class HomeListViewModelTests: XCTestCase {
    var subject: HomeListViewModel!
    var newsServiceMock: NewsServiceMock! = NewsServiceMock()
    var store = Set<AnyCancellable>()

    override func setUpWithError() throws {
        subject = HomeListViewModel(newsService: newsServiceMock)
    }

    override func tearDownWithError() throws {
        subject = nil
    }


    func test_fetchNews_Pending() throws {
        let exp = XCTestExpectation(description: "test_fetchNews_Pending")
        var expectedState: HomeListViewModelState!
        newsServiceMock.newsPublisher = Result.success(News.news).publisher.eraseToAnyPublisher()

        subject.$state.first().sink { state in
            expectedState = state
            switch state {
            case .pending:
                exp.fulfill()
                break
            case .finished(_):
                XCTFail("Wrong state .finished")
            case .failure(_):
                XCTFail("Wrong state .failure")
            }

        }.store(in: &store)

        subject.fetchNews(section: .all)

        XCTAssertNotNil(expectedState)
        wait(for: [exp], timeout: 1)
    }

    func test_fetchNews_Success() throws {
        let exp = XCTestExpectation(description: "test_fetchNews_Success")
        var expectedState: HomeListViewModelState!
        newsServiceMock.newsPublisher = Result.success(News.news).publisher.eraseToAnyPublisher()

        subject.$state.dropFirst(2).sink { state in
            expectedState = state
            switch state {
            case .pending:
                XCTFail("Wrong state .pending")
            case .finished(let articles):
                XCTAssertEqual(articles.count, 2)
            case .failure(_):
                XCTFail("Wrong state .failure")
            }
            exp.fulfill()
        }.store(in: &store)

        subject.fetchNews(section: .all)

        XCTAssertNotNil(expectedState)
        wait(for: [exp], timeout: 1)
    }

    func test_fetchNews_Failure_Unk() throws {
        let exp = XCTestExpectation(description: "test_fetchNews_Failure")
        var expectedState: HomeListViewModelState!
        let expError = APIError.unknown
        newsServiceMock.newsPublisher = Fail(error: expError).eraseToAnyPublisher()

        subject.$state.dropFirst(2).sink { state in
            expectedState = state
            switch state {
            case .pending:
                XCTFail("Wrong state .pending")
            case .finished(_):
                XCTFail("Wrong state .finished")
            case .failure(let error):
                guard let error = error as? APIError else {
                    XCTFail("Error is not a APIError type")
                    return
                }
                switch error {
                case .decoding:
                    XCTFail("Wrong state .decoding")
                case .code(_):
                    XCTFail("Wrong state .code")
                case .unknown:
                    exp.fulfill()
                }
            }

        }.store(in: &store)

        subject.fetchNews(section: .all)

        XCTAssertNotNil(expectedState)
        wait(for: [exp], timeout: 1)
    }
}
