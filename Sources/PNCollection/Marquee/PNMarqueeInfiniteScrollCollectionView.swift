//
//  PNMarqueeInfiniteCollectionView.swift
//  PNCollection
//
//  Created by P.Nam on 19/11/2022.
//

import UIKit

open class PNMarqueeInfiniteScrollCollectionView: PNInfiniteScrollCollectionView, PNBaseMarqueeCollectionView {
    private var isConfig: Bool = false
    open var direction: PNMarqueeDirection = .horizontal
    open var isRunning: Bool = false {
        didSet {
            isPausedScroll = false
        }
    }
    open var isPausedScroll: Bool = false
    open var scrollSpeed: Double = 5
    open var autoScrollForSection: Int = .zero
    open var isAutoScroll = true
    open var duration: TimeInterval {
        1 / scrollSpeed
    }
    
    open override var contentOffset: CGPoint {
        willSet {
            if isPausedScroll {
                startAutoScroll()
            }
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if !isConfig {
            isConfig = true
            addTapGesture(action: #selector(tapHandler))
        }
    }
    
    @objc private func tapHandler(_ sender: UITapGestureRecognizer) {
        if sender.state == .began {
            stopAutoScroll()
        } else if sender.state == .ended {
            startAutoScroll()
        }
    }
}
