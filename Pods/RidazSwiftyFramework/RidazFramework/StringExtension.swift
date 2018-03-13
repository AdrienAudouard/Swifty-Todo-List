//
//  StringExtension.swift
//  RidazFramework
//
//  Created by Adrien Audouard on 01/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation

public extension String {
    
    /// Return a new String with the first letter uppercased
    ///
    /// - Returns: <#return value description#>
    public func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    
    /// Uppercase the first letter of this String
    public mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
