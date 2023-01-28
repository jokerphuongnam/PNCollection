//
//  PNInfiniteScrollCollectionViewDataSource.swift
//  PNCollection
//
//  Created by P.Nam on 11/11/2022.
//

import UIKit

public protocol PNInfiniteScrollCollectionViewDataSource: UICollectionViewDataSource {
    func numberOfSets(in collectionView: UICollectionView) -> Int
}
