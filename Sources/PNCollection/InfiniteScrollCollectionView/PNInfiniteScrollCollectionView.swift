//
//  PNInfiniteScrollCollectionView.swift
//  PNCollection
//
//  Created by P.Nam on 11/11/2022.
//

import UIKit

private var dataSourceKey: Void?

public typealias PNVisibleItem = (indexPath: IndexPath, frame: CGRect)

open class PNInfiniteScrollCollectionView: UICollectionView {
    private var isLayoutSubViews = false
    private var isConfig = false
    
    open var numberOfSets: Int = 0
    open var count: Int = 0
    
    open var leftResetPosition: Int {
        numberOfSets - 1 + leftResetPositionThreshold
    }
    
    open var leftResetToPosition: Int {
        numberOfSets + leftResetToPositionThreshold
    }
    
    open var rightResetPosition: Int {
        count + numberOfSets + rightResetPositionThreshold
    }
    
    open var rightResetToPosition: Int {
        count + numberOfSets - 1 + rightResetToPositionThreshold
    }
    
    open weak var infiniteDataSource: PNInfiniteScrollCollectionViewDataSource! {
        willSet {
            if let newValue = newValue {
                count = newValue.collectionView(self, numberOfItemsInSection: 0)
                numberOfSets = newValue.numberOfSets(in: self)
                setRetainedAssociatedObject(&dataSourceKey, PNInfiniteScrollCollectionDataSource(newValue))
                dataSource = getAssociatedObject(&dataSourceKey)
                if isLayoutSubViews {
                    layoutIfNeeded()
                    resetPosition()
                }
            } else {
                removeRetainedAssociatedObject(&dataSourceKey)
            }
        }
    }
    
    open override var contentOffset: CGPoint {
        didSet {
            let infiniteIndexPathsForVisibleItems = infiniteIndexPathsForVisibleItems
            let visibleCells = visibleCells
            if !infiniteIndexPathsForVisibleItems.isEmpty, !visibleCells.isEmpty {
                let visibleItems: [PNVisibleItem] = visibleCells.compactMap { cell in
                    if let indexPathOfCell = self.indexPath(for: cell) {
                        if infiniteIndexPathsForVisibleItems.contains(indexPathOfCell) {
                            return PNVisibleItem(indexPathOfCell, cell.frame)
                        }
                    }
                    return nil
                }
                infiniteScroll(by: visibleItems, and: contentOffset, with: contentSize.width > frame.width ? .horizontal : .vertical)
            }
        }
    }
    
    open override func layoutSubviews() {
        isLayoutSubViews = true
        super.layoutSubviews()
        if !isConfig {
            isConfig = true
            resetPosition()
        }
    }
    
    open override func reloadData() {
        super.reloadData()
        isConfig = false
        resetCount()
    }
    
    open override func insertSections(_ sections: IndexSet) {
        super.insertSections(sections)
        isConfig = false
        resetCount()
    }
    
    open override func deleteSections(_ sections: IndexSet) {
        super.deleteSections(sections)
        isConfig = false
        resetCount()
    }
    
    open override func moveSection(_ section: Int, toSection newSection: Int) {
        super.moveSection(section, toSection: newSection)
        isConfig = false
        resetCount()
    }
    
    open override func reloadSections(_ sections: IndexSet) {
        super.reloadSections(sections)
        isConfig = false
        resetCount()
    }
    
    open override func insertItems(at indexPaths: [IndexPath]) {
        super.insertItems(at: indexPaths)
        isConfig = false
        resetCount()
    }
    
    open override func deleteItems(at indexPaths: [IndexPath]) {
        super.deleteItems(at: indexPaths)
        isConfig = false
        resetCount()
    }
    
    open override func moveItem(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        super.moveItem(at: indexPath, to: newIndexPath)
        isConfig = false
        resetCount()
    }
    
    open override func reloadItems(at indexPaths: [IndexPath]) {
        super.reloadItems(at: indexPaths)
        isConfig = false
        resetCount()
    }
    
    @available(iOS 15.0, *)
    open override func reconfigureItems(at indexPaths: [IndexPath]) {
        super.reconfigureItems(at: indexPaths)
        isConfig = false
        resetCount()
    }
    
    open func infiniteScroll(by visibleItems: [PNVisibleItem], and contentOffset: CGPoint, with direction: UICollectionView.ScrollDirection) {
        let leftResetPosition = leftResetPosition
        let rightResetPosition = rightResetPosition
        let firstCell = visibleItems.first { visibleItem in
            visibleItem.indexPath.item == leftResetPosition
        }
        let lasCell = visibleItems.first { visibleItem in
            visibleItem.indexPath.item == rightResetPosition
        }
        let offset = direction == .vertical ? contentOffset.y : contentOffset.x
        if let firstCell = firstCell {
            let firstPosition = direction == .vertical ? firstCell.frame.minY: firstCell.frame.minX
            if offset < firstPosition {
                let toItem = rightResetToPosition
                infiniteScrollToItem(at: [0, toItem], at: direction == .vertical ? .bottom : .left)
            }
        } else if let lasCell = lasCell {
            let lastPosition = direction == .vertical ? lasCell.frame.minY: lasCell.frame.minX
            let lastSize = direction == .vertical ? lasCell.frame.height: lasCell.frame.width
            if offset + lastSize > lastPosition {
                resetPosition()
            }
        } else if visibleItems.count == 1, let firstItem = visibleItems.first {
            if firstItem.indexPath.item <= leftResetPosition {
                let toItem = rightResetToPosition
                infiniteScrollToItem(at: [0, toItem], at: direction == .vertical ? .bottom : .left)
            } else if firstItem.indexPath.item >= rightResetPosition {
                resetPosition()
            }
        }
    }
    
    private func resetPosition() {
        guard count > 0 else { return }
        numberOfSets = numberOfSets == 0 ? infiniteDataSource?.numberOfSets(in: self) ?? 0 : numberOfSets
        let item = numberOfSets
        let section = 0
        let indexPath = IndexPath(item: item, section: section)
        infiniteScrollToItem(at: indexPath, at: .top)
        infiniteScrollToItem(at: indexPath, at: .left)
        layoutIfNeeded()
    }
    
    private func resetCount() {
        guard let infiniteDataSource = infiniteDataSource else {
            return
        }
        count = infiniteDataSource.collectionView(self, numberOfItemsInSection: 0)
        numberOfSets = infiniteDataSource.numberOfSets(in: self)
    }
}
