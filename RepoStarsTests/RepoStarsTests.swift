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
        self.loadData(completion: { data in
            self.repoData = data
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 30)
        
        XCTAssertNotNil(self.repoData)
        XCTAssertNotEqual(self.repoData?.items.count, 0)
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
    
    func test_loadData_withItems() {
        let exp = expectation(description: "Load repo data")
        self.loadData(completion: { data in
            self.repoData = data
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 30)
        
        let vc = self.makeView(item: self.repoData)
        
        XCTAssertNotEqual(vc.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_loadData_renderItemText() {
        let item = self.makeDummyData()
        
        let vc = self.makeView(item: item)
        
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = vc.tableView.dataSource?.tableView(vc.tableView, cellForRowAt: indexPath) as? RepoStarTableViewCell
        
        XCTAssertEqual(cell?.authorNameLabel.text, "login")
    }
    
    // MARK: Helper
    
    private func loadData(completion: @escaping (RepoModel?) -> Void) {
        self.sut.load() { data in
            completion(data)
        }
    }
    
    private func makeView(item: RepoModel? = nil) -> ViewController {
        let newVc = ViewController(item: item)
        
        _ = newVc.view
        
        return newVc
    }
    
    private func makeDummyData() -> RepoModel {
        let io = itemOwner(login: "login", avatar_url: "avatar")
        let i = itemRepo(id: 1, name: "name", full_name: "full_name", stargazers_count: 1, owner: io)
        let r = RepoModel(total_count: 1, items: [i])
        return r
    }
}
