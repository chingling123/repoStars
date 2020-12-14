//
//  RepoStarsTests.swift
//  RepoStarsTests
//
//  Created by Erik Nascimento on 12/12/20.
//

import XCTest
@testable import RepoStars

class RepoStarsTests: XCTestCase {

    var repoData: [itemRepo]?
    let sut = RepoDataSource()
    let exp = XCTestExpectation()
    
    func test_dataLoader() {
        sut.delegate = self
        sut.load()
                
        wait(for: [self.exp], timeout: 30)
        
        XCTAssertNotNil(self.repoData)
        XCTAssertNotEqual(self.repoData?.count, 0)
    }

    func test_headerTitleViewController() {
        let vc = self.makeView()
        
        XCTAssertEqual(vc.headerLabel.text, "RepoStars")
    }
    
    func test_hasTableView() {
        let vc = self.makeView()

        guard let view = vc.view else { return }
        
        let hasTable = view.subviews.filter({
            $0 is UITableView
        })
        
        XCTAssertNotEqual(hasTable.count, 0)
    }
    
    func test_ViewDidLoad_noItems() {
        let vc = self.makeView()

        XCTAssertEqual(vc.tableView.numberOfRows(inSection: 0), 0)
    }
    
    // MARK: Helper
    
    private func makeView() -> ViewController {
        let newVc = ViewController()
        
        _ = newVc.view
        
        return newVc
    }
}

extension RepoStarsTests: RepoDataSourceDelegate {
    func fetchCompleted(indexes: [IndexPath]?) {
        self.repoData = self.sut.itemsToDisplay
        self.exp.fulfill()
    }
    
    func fetchError() {
        
    }

}
