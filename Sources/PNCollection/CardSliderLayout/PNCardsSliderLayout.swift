//
//  PNCardsSliderLayout.swift
//  PNCollection
//
//  Created by P.Nam on 19/11/2022.
//

import UIKit

public protocol PNCardsSliderLayoutDelegate: AnyObject {
    func cardsSliderLayout(_ layout: PNCardsSliderLayout, didUpdateSize size: CGSize)
    func cardsSliderLayout(_ layout: PNCardsSliderLayout, didUpdateSelectedItem index: Int)
}

open class PNCardsSliderLayout: UICollectionViewLayout {
    open weak var delegate: PNCardsSliderLayoutDelegate? = nil
    fileprivate let size = UIScreen.main.bounds
    fileprivate lazy var contentSize: CGSize = {
        let cellWidth = contentWidth - 16 * CGFloat(numberOfItemsVisible)
        let cellHeight = cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }()
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.width - 16
    }
    
    fileprivate var contentHeight: CGFloat = 0
    fileprivate lazy var cacheAttributes: [UICollectionViewLayoutAttributes] = initCacheAttributes()
    
    public var selectedItem: Int {
        get {
            guard let collectionView = collectionView else { return 0 }
            let selectedItem = min(max(Int(collectionView.contentOffset.x) / Int(collectionView.bounds.width), 0), collectionView.numberOfItems(inSection: 0))
            let selectedItemDouble = collectionView.contentOffset.x / collectionView.bounds.width
            let selectedItemIsInteger = Double(selectedItemDouble) == Double(selectedItem)
            if selectedItemIsInteger || collectionView.contentOffset.x < 0 {
                delegate?.cardsSliderLayout(self, didUpdateSelectedItem: selectedItem)
            }
            return selectedItem
        }
        set {
            guard let collectionView = collectionView else { return }
            collectionView.setContentOffset(CGPoint(x: CGFloat(newValue) * collectionView.frame.width, y: 0), animated: false)
        }
    }
    
    public var exactSelectedItem: Int? {
        guard let collectionView = collectionView else { return 0 }
        let selectedItem = min(max(Int(collectionView.contentOffset.x) / Int(collectionView.bounds.width), 0), collectionView.numberOfItems(inSection: 0))
        let selectedItemDouble = collectionView.contentOffset.x / collectionView.bounds.width
        return Double(selectedItemDouble) == Double(selectedItem) ? selectedItem : nil
    }
    
    open var numberOfItemsVisible: Int = 3
    
    private var prepareCollectionViewContentSize: CGSize? = nil
    open override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth * CGFloat((collectionView?.numberOfItems(inSection: 0) ?? 0)), height: contentHeight)
    }
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    open override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else {
            return
        }
        let size = contentSize
        contentHeight = size.height
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        if prepareCollectionViewContentSize?.width ?? 0.0 != collectionViewContentSize.width || prepareCollectionViewContentSize?.height ?? 0.0 != collectionViewContentSize.height {
            delegate?.cardsSliderLayout(self, didUpdateSize: collectionViewContentSize)
            prepareCollectionViewContentSize = collectionViewContentSize
        }
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let count = collectionView.numberOfItems(inSection: 0)
        if cacheAttributes.isEmpty && count != 0 {
            cacheAttributes = initCacheAttributes()
        }
        let baseAttributes = cacheAttributes.compactMap { $0.copy() as? UICollectionViewLayoutAttributes }
        
        let size = contentSize
        let selectedItem = selectedItem
        let contentOffsetX = collectionView.contentOffset.x
        let selectedItemDouble = collectionView.contentOffset.x / collectionView.bounds.width
        let ratioScreenOffsetX = selectedItemDouble - CGFloat(selectedItem)
        let screenOffsetX = 16.0 * ratioScreenOffsetX
        let selectedItemIsInteger = Double(selectedItemDouble) == Double(selectedItem)
        let defaultMaxVisibleItem: Int
        if selectedItemIsInteger || collectionView.contentOffset.x < 0 {
            defaultMaxVisibleItem = numberOfItemsVisible
        } else {
            defaultMaxVisibleItem = numberOfItemsVisible + 1
        }
        let maxVisibleItem = min(count - selectedItem, defaultMaxVisibleItem)
        let layoutAttributes = (0..<maxVisibleItem).map { index -> UICollectionViewLayoutAttributes in
            let visibleIndex = selectedItem + index
            let reverseIndex = maxVisibleItem - index
            let attributes = baseAttributes[visibleIndex]
            
            attributes.zIndex = reverseIndex
            
            let calculateOffsetX = CGFloat(16 * (index + 1))
            let cellOffsetX: CGFloat
            if selectedItem == visibleIndex {
                let calOffsetX = calculateOffsetX + CGFloat(selectedItem) * collectionView.bounds.width
                cellOffsetX = min(calOffsetX, calculateOffsetX + contentOffsetX)
            } else {
                cellOffsetX = calculateOffsetX + contentOffsetX - screenOffsetX
            }
            
            attributes.frame = CGRect(x: cellOffsetX, y: 0, width: size.width, height: size.height)
            
            attributes.transform = CGAffineTransform(scaleX: 1, y: (size.height - CGFloat(index * 16) + screenOffsetX) / size.height)
            
            if ratioScreenOffsetX > 1/3 && selectedItem == visibleIndex {
                attributes.alpha = 1 - (ratioScreenOffsetX - 1/3)
            } else if !selectedItemIsInteger && index == maxVisibleItem - 1 {
                attributes.alpha = ratioScreenOffsetX
            }
            
            return attributes
        }
        return layoutAttributes.sorted { lhs, rhs in
            lhs.indexPath.item < rhs.indexPath.item
        }
    }
    
    private func initCacheAttributes() -> [UICollectionViewLayoutAttributes] {
        guard let collectionView = collectionView else { return [] }
        let count = collectionView.numberOfItems(inSection: 0)
        return (0..<count).map { index in
            UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: index, section: 0))
        }
    }
}
