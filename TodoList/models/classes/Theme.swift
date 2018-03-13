//
//  Theme.swift
//  TodoList
//
//  Created by Adrien Audouard on 05/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import UIKit

class Theme {
    // swiftlint:disable line_length
    static let dark = Theme(textColor: "#ffffff", backgroundColor: "222F3E", navBarBackgroundColor: "1A2228", navBarItemColor: "#ffffff")
    // swiftlint:disable line_length
    static let clear = Theme(textColor: "222F3E", backgroundColor: "#ffffff", navBarBackgroundColor: "#ecf0f1", navBarItemColor: "1A2228")
    
    var textColor: UIColor
    var backgroundColor: UIColor
    var navBarBackgroundColor: UIColor
    var navBarItemColor: UIColor
    
    init(textColor: String, backgroundColor: String, navBarBackgroundColor: String, navBarItemColor: String) {
        self.textColor =  UIColor(hexString: textColor) //textColor
        self.backgroundColor = UIColor(hexString: backgroundColor)
        self.navBarBackgroundColor = UIColor(hexString: navBarBackgroundColor)
        self.navBarItemColor = UIColor(hexString: navBarItemColor)
    }
}
