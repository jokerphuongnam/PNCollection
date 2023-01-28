//
//  PNBaseInfiniteScrollCollectionView.swift
//  PNCollection
//
//  Created by pnam on 27/01/2023.
//

import UIKit

internal protocol PNBaseInfiniteScrollCollectionView {
    var infiniteIndexPathsForVisibleItems: [IndexPath] { get }
    var leftResetPositionThreshold: Int { get }
    var leftResetToPositionThreshold: Int { get }
    var rightResetPositionThreshold: Int { get }
    var rightResetToPositionThreshold: Int { get }
    
    func infiniteScrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition)
}

extension UICollectionView: PNBaseInfiniteScrollCollectionView {
    @objc open var infiniteIndexPathsForVisibleItems: [IndexPath] {
        indexPathsForVisibleItems
    }
    
    @objc open var leftResetPositionThreshold: Int {
        0
    }
    
    @objc open var leftResetToPositionThreshold: Int {
        0
    }
    
    @objc open var rightResetPositionThreshold: Int {
        0
    }
    
    @objc open var rightResetToPositionThreshold: Int {
        0
    }
    
    @objc open func infiniteScrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition) {
        scrollToItem(at: indexPath, at: scrollPosition, animated: false)
        scrollToItem(at: indexPath, at: scrollPosition, animated: false)
    }
}
