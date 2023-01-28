//
//  NMInfiniteScrollCollectionView+CardsSlider.swift
//  PNCollection
//
//  Created by P.Nam on 22/11/2022.
//

import UIKit

extension PNInfiniteScrollCollectionView {
    open override var infiniteIndexPathsForVisibleItems: [IndexPath] {
        if let layout = collectionViewLayout as? PNCardsSliderLayout {
            if let exactSelectedItem = layout.exactSelectedItem {
                return [[0, exactSelectedItem]]
            } else {
                return []
            }
        } else {
            return super.indexPathsForVisibleItems
        }
    }
    
    open override var leftResetPositionThreshold: Int {
        collectionViewLayout is PNCardsSliderLayout ? -1 : 0
    }
    
    open override func infiniteScrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition) {
        if let layout = collectionViewLayout as? PNCardsSliderLayout {
            layout.selectedItem = indexPath.item
        } else {
            super.scrollToItem(at: indexPath, at: scrollPosition, animated: false)
        }
    }
}
