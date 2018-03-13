//
//  ArrayExtension.swift
//  RidazFramework
//
//  Created by Adrien Audouard on 22/02/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation

public extension Array {
    
    /// Remove the first element that matches the handler
    /// Example: list.remove { $0 == 2 }
    ///
    /// - Parameter handler:
    /// - Returns: Element removed
    public mutating func remove(handler: (Element) -> Bool) -> Element? {
        guard let idx = index(where: handler) else {
            return nil
        }
        
        let item = self[idx]
        remove(at: idx)
        return item
    }
}
