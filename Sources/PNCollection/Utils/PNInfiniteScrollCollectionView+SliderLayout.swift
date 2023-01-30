//
//  PNInfiniteScrollCollectionView+SliderLayout.swift
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
    
    open override func infiniteScrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition) {
        if let layout = collectionViewLayout as? PNCardsSliderLayout {
            layout.selectedItem = indexPath.item
        } else {
            super.scrollToItem(at: indexPath, at: scrollPosition, animated: false)
        }
    }
}
