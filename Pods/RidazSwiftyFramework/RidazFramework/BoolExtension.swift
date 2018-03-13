//
//  BoolExtension.swift
//  RidazFramework
//
//  Created by Adrien Audouard on 22/02/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation

public extension Bool {
    
    /// Reverse the value
    /// Useful when the Bool is optionnal because we can not use !
    var not: Bool {
        return !self
    }
}
