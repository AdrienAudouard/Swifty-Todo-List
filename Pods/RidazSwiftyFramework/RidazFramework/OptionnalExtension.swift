
//
//  OptionnalExtension.swift
//  RidazFramework
//
//  Created by Adrien Audouard on 22/02/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation

public extension Optional {
    
    /// Execute the handler if it's not nil
    /// Example: name.then { print($0) }
    /// - Parameter handler: Handler to execute
    func then(handler: (Wrapped) -> Void) {
        switch self {
        case .some(let w):
            return handler(w)
        default:
            break
        }
    }
}
