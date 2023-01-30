//
//  PNInfiniteScrollCollectionDataSource.swift
//  PNCollection
//
//  Created by P.Nam on 18/11/2022.
//

import UIKit

internal final class PNInfiniteScrollCollectionDataSource: NSObject {
    weak var dataSource: PNInfiniteScrollCollectionViewDataSource!
    
    init(_ dataSource: PNInfiniteScrollCollectionViewDataSource?) {
        self.dataSource = dataSource
    }
}

extension PNInfiniteScrollCollectionDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = dataSource else { return .zero }
        let count = dataSource.collectionView(collectionView, numberOfItemsInSection: 0)
        let numberOfSets = dataSource.numberOfSets(in: collectionView)
        return count + (count == 0 ? 0 : 2 * numberOfSets)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataSource = dataSource else { return UICollectionViewCell(frame: .zero) }
        let count = dataSource.collectionView(collectionView, numberOfItemsInSection: 0)
        let numberOfSets = dataSource.numberOfSets(in: collectionView)
        var calculateIndex = (indexPath.row - numberOfSets) % count
        if calculateIndex < 0  {
            calculateIndex = count - abs(calculateIndex)
        }
        return dataSource.collectionView(collectionView, cellForItemAt: [0, calculateIndex])
    }
}
