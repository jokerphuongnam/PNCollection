//
//  NSObject+Extension.swift
//  PNCollectionExample
//
//  Created by pnam on 27/01/2023.
//

import Foundation

extension NSObject {
    class var name: String {
        String(describing: Self.self)
    }
}
