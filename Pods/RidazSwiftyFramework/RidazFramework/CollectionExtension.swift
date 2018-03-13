//
//  CollectionExtension.swift
//  RidazFramework
//
//  Created by Adrien Audouard on 22/02/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation

public extension Collection where Iterator.Element: Equatable{
    
    
    /// Return the element after the param
    ///
    /// - Parameter element: Element searched
    /// - Returns: Element after the param
    public func after(_ element: Iterator.Element) -> Iterator.Element? {
        guard let idx = index(of: element), index(after: idx) < endIndex else { return nil }
        let nextIdx = index(after: idx)
        return self[nextIdx]
    }
    
    
    /// Return the element before the param
    ///
    /// - Parameter element: Element searched
    /// - Returns: Element before the param
    public func before(_ element: Iterator.Element) -> Iterator.Element? {
        guard let idx = index(of: element), index(before: idx) >= startIndex else { return nil }
        let previousIdx = index(idx, offsetBy: -1)
        return self[previousIdx]
    }
    
    
    /// Return the index of the element before the param
    ///
    /// - Parameter idx: Element searched
    /// - Returns: Index of the element before the param
    public func index(before idx: Index) -> Index {
        return index(idx, offsetBy: -1)
    }
}
