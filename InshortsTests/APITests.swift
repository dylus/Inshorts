//
//  APITests.swift
//  InshortsTests
//
//  Created by Michal Dylka on 21/05/2022.
//

import XCTest
@testable import Inshorts

class APITests: XCTestCase {
    func test_Endpoint_ShouldBeValid() throws {
        Endpoint.allCases.forEach {
            let urlRequest = $0.urlRequest
            XCTAssertEqual(urlRequest.httpMethod, "GET", "Wrong HTTP Method for \($0.rawValue)")
            XCTAssertEqual(urlRequest.url?.absoluteString, "https://inshorts.deta.dev/news?category=\($0.rawValue)", "Wrong Path for \($0.rawValue)")
        }
    }
}
