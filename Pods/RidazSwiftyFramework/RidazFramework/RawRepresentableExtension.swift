//
//  RawRepresentableExtension.swift
//  RidazFramework
//
//  Created by Adrien Audouard on 22/02/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation

public extension RawRepresentable where RawValue == Int {
    
    
    /// Return the number of item in the enum
    static var itemsCount: Int {
        var index = 0
        while Self(rawValue: index) != nil {
            index += 1
        }
        return index
    }
    
    
    /// Return a array containing each value of the enum
    static var items: [Self] {
        var items: [Self] = [Self]()
        var index = 0
        while let item = Self(rawValue: index) {
            items.append(item)
            index += 1
        }
        
        return items
    }
}
