//
//  DataSource.swift
//  RepoStars
//
//  Created by Erik Nascimento on 12/12/20.
//

import Foundation

protocol RepoDataSourceDelegate: class {
    func fetchCompleted(indexes: [IndexPath]?)
    func fetchError()
}

class RepoDataSource {
    var isInProgress = false
    var itemsToDisplay = [itemRepo]()
    var currentPage = 1
    
    weak var delegate: RepoDataSourceDelegate?
    
    func refresh() {
        self.itemsToDisplay = [itemRepo]()
        self.load()
    }
    
    func load()
    {
        guard !isInProgress else {
            return
        }
        
        isInProgress = true
        NetworkManager.LoadData(page: currentPage) { [weak self] (data) in
            DispatchQueue.main.async {
                guard let hasData = data else {
                    self?.delegate?.fetchError()
                    return
                }
                
                self?.isInProgress = false
                
                self?.itemsToDisplay.append(contentsOf: hasData.items)
                
                if self?.currentPage ?? 0 > 1 {
                    let newIndexes = self?.calculateIndexes(newItens: hasData.items)
                    self?.delegate?.fetchCompleted(indexes: newIndexes)
                } else {
                    self?.delegate?.fetchCompleted(indexes: nil)
                }
                
                self?.currentPage += 1
            }
        }
    }
    
    private func calculateIndexes(newItens: [itemRepo]) -> [IndexPath] {
        let startIdx = self.itemsToDisplay.count - newItens.count
        let endIdx = startIdx + newItens.count
        return (startIdx..<endIdx).map {IndexPath(row: $0, section: 0)}
    }
}
