//
//  PNMarqueeCollectionView.swift
//  
//
//  Created by pnam on 28/01/2023.
//

import UIKit

open class PNMarqueeCollectionView: UICollectionView, PNBaseMarqueeCollectionView {
    private var isConfig: Bool = false
    open var direction: UICollectionView.ScrollDirection = .horizontal
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
        didSet {
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
