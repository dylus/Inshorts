//
//  APIErrorTests.swift
//  InshortsTests
//
//  Created by Michal Dylka on 21/05/2022.
//

import XCTest
@testable import Inshorts

class APIErrorTests: XCTestCase {
    func test_Error_Decoding_Descrption() throws {
        XCTAssertEqual(APIError.decoding.description, "Decode Error")
    }

    func test_Error_Code() throws {
        let code = 400
        XCTAssertEqual(APIError.code(code).description, "\(code) - Error code")
    }

    func test_Error_Unknow() throws {
        XCTAssertEqual(APIError.unknown.description, "Unknown error")
    }
}
