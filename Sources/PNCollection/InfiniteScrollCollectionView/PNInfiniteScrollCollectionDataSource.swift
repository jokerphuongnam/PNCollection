//
//  PNInfiniteScrollCollectionDataSource.swift
//  PNCollection
//
//  Created by P.Nam on 18/11/2022.
//

import UIKit

internal final class PNInfiniteScrollCollectionDataSource: NSObject {
    weak var dataSource: PNInfiniteScrollCollectionViewDataSource!
    private let realCount: Int
    private let numberOfSets: Int
    
    init(_ dataSource: PNInfiniteScrollCollectionViewDataSource?, realCount: Int, numberOfSets: Int) {
        self.dataSource = dataSource
        self.realCount = realCount
        self.numberOfSets = numberOfSets
    }
}

extension PNInfiniteScrollCollectionDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = realCount
        let numberOfSets = numberOfSets
        return count + (count == 0 ? 0 : 2 * numberOfSets)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataSource = dataSource else { return UICollectionViewCell(frame: .zero) }
        var calculateIndex = (indexPath.row - numberOfSets) % realCount
        if calculateIndex < 0  {
            calculateIndex = realCount - abs(calculateIndex)
        }
        return dataSource.collectionView(collectionView, cellForItemAt: [0, calculateIndex])
    }
}
