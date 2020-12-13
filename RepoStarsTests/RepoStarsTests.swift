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
    let vc = ViewController()

    func test_dataLoader() {
        let exp = expectation(description: "Load repo data")
        self.loadData(completion: { data in
            self.repoData = data
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 30)
        
        XCTAssertNotNil(self.repoData)
        XCTAssertNotEqual(self.repoData?.items.count, 0)
    }

    func test_headerTitleViewController() {
        let _ = vc.view
        
        XCTAssertEqual(vc.headerLabel.text, "RepoStars")
    }
    
    func test_hasTableView() {
        guard let view = vc.view else { return }
        
        let hasTable = view.subviews.filter({
            $0 is UITableView
        })
        
        XCTAssertNotEqual(hasTable.count, 0)
    }
    
    func test_ViewDidLoad_NoItems() {
        _ = vc.view
        XCTAssertEqual(vc.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_ViewDidLoad_WithItems() {
        let exp = expectation(description: "Load repo data")
        self.loadData(completion: { data in
            self.repoData = data
            exp.fulfill()
        })
        
        let newVc = ViewController(item: self.repoData)
        
        _ = newVc.view
        
        waitForExpectations(timeout: 30)
        
        XCTAssertNotEqual(newVc.tableView.numberOfRows(inSection: 0), 0)
    }
    
    // MARK: Helper
    
    private func loadData(completion: @escaping (RepoModel?) -> Void) {
        self.sut.load() { data in
            completion(data)
        }
    }
}
