//
//  RepoStarsTests.swift
//  RepoStarsTests
//
//  Created by Erik Nascimento on 12/12/20.
//

import XCTest
@testable import RepoStars

class RepoStarsTests: XCTestCase {

    var repoData: RepoModel?
    let sut = RepoDataSource()
    
    func test_dataLoader() {
        
        let exp = expectation(description: "Load repo data")
        
        self.sut.load() { data in
            self.repoData = data
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 30)
        
        XCTAssertNotNil(self.repoData)
    }

}
