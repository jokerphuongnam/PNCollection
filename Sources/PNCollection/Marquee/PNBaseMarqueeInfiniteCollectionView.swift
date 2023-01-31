//
//  PNBaseMarqueeCollectionView.swift
//  PNCollection
//
//  Created by pnam on 28/01/2023.
//

import UIKit

public protocol PNBaseMarqueeCollectionView: AnyObject {
    var duration: TimeInterval { get }
    var direction: UICollectionView.ScrollDirection { get set }
    var animator: UIViewPropertyAnimator? { get set }
    var scrollSpeed: Double { get set }
    var isRunning: Bool { get set }
    var isDuringAnimation: Bool { get set }
    var isAutoScroll: Bool { get set }
    var autoScrollForSection: Int { get set }
    var isPausedScroll: Bool { get set }
    func setContentOffset(for scrollView: UIScrollView)
}

extension PNBaseMarqueeCollectionView where Self: UICollectionView {
    private func isLastItemFullyVisible(for scrollView: UIScrollView) -> Bool {
        let numberOfItems = numberOfItems(inSection: 0)
        if numberOfItems == 0 {
            return false
        }
        let lastIndexPath = IndexPath(item: numberOfItems - 1, section: 0)
        
        guard let attrs = collectionViewLayout.layoutAttributesForItem(at: lastIndexPath)
        else {
            return false
        }
        return scrollView.bounds.contains(attrs.frame)
    }
    
    public func setContentOffset(for scrollView: UIScrollView) {
        isPausedScroll = false
        let duration = duration
        if !isDuringAnimation {
            if !isDragging {
                isDuringAnimation = true
                animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: duration * 1.1, delay: 0, options: [.allowUserInteraction, .curveLinear]) { [weak self] in
                    guard let self = self else { return }
                    if self.isDuringAnimation {
                        switch self.direction {
                        case .vertical:
                            scrollView.contentOffset.y += self.scrollSpeed
                        case .horizontal:
                            scrollView.contentOffset.x += self.scrollSpeed
                        @unknown default:
                            break
                        }
                        self.layoutIfNeeded()  
                    }
                } completion: { isFinished in
                    
                }
            } else {
                removeAnimate()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            guard let self = self else { return }
            if !self.isLastItemFullyVisible(for: scrollView) {
                if self.isRunning {
                    self.setContentOffset(for: scrollView)
                }
            } else {
                self.isPausedScroll = true
            }
            self.isDuringAnimation = false
        }
    }
    
    public func resetAutoScroll() {
        if isPausedScroll {
             startAutoScroll()
        }
    }
    
    public func addTapGesture(action tapHandler: Selector) {
        let tapGesture = UILongPressGestureRecognizer(target: self, action: tapHandler)
        addGestureRecognizer(tapGesture)
        if isAutoScroll {
            setAutoScrollSpeed()
        }
    }
    
    // - MARK: Start marquee
    public func startAutoScroll() {
        stopAutoScroll()
        setAutoScrollSpeed()
    }
    
    private func setAutoScrollSpeed() {
        isRunning = true
        setupTimer()
    }
    
    private func setupTimer() {
        let subScrollViews = subScrollViews
        if subScrollViews.isEmpty || autoScrollForSection < 0 {
            setContentOffset(for: self)
        } else if autoScrollForSection >= subScrollViews.count - 1 {
            setContentOffset(for: subScrollViews[subScrollViews.count - 1])
        } else {
            setContentOffset(for: subScrollViews[autoScrollForSection])
        }
    }
    
    // - MARK: Stop marquee
    public func stopAutoScroll() {
        invalidateTimer()
        removeAnimate()
    }
    
    func removeAnimate() {
        let subScrollViews = subScrollViews
        if subScrollViews.isEmpty || autoScrollForSection < 0 {
            stopAnimateScroll(for: self)
        } else if autoScrollForSection > subScrollViews.count - 1 {
            stopAnimateScroll(for: subScrollViews[subScrollViews.count - 1])
        } else {
            stopAnimateScroll(for: subScrollViews[autoScrollForSection])
        }
    }
    
    private func stopAnimateScroll(for scrollView: UIScrollView) {
        animator?.stopAnimation(true)
        animator = nil
    }
    
    private func invalidateTimer() {
        isRunning = false
    }
}
