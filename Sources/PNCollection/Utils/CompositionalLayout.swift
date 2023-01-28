//
//  CompositionalLayout.swift
//  PNCollection
//
//  Created by pnam on 28/01/2023.
//

import UIKit

@available(iOS 13.0, *)
public extension NSCollectionLayoutVisibleItem {
    var pnVisibleItem: PNVisibleItem {
        PNVisibleItem(indexPath, frame)
    }
}
