//
//  StringUtils.swift
//  pncollectionExample
//
//  Created by pnam on 27/01/2023.
//

import Foundation

extension String {
    var capitalizingFirstLetter: String {
        prefix(1).capitalized + dropFirst()
    }
}
