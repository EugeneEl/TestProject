//
//  Foundation+Extensions.swift
//  EGS
//
//  Created by Eugene Goloboyar on 20.03.2018.

import Foundation

extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
