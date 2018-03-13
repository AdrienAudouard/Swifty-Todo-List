//
//  CustomItemRamAnimation.swift
//  TodoList
//
//  Created by Adrien Audouard on 09/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import RAMAnimatedTabBarController

class CustomItemRamAnimation: RAMBounceAnimation {
    
    static var deselectedColor = UIColor(hex: "#7f8c8d")
    static var selectedColor = UIColor(hex: "#ecf0f1")
    
    override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        super.playAnimation(icon, textLabel: textLabel)
        
        textLabel.textColor = CustomItemRamAnimation.selectedColor
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = CustomItemRamAnimation.selectedColor
    }
    
    override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
        super.deselectAnimation(icon, textLabel: textLabel, defaultTextColor: defaultTextColor, defaultIconColor: defaultIconColor)
        
        textLabel.textColor = CustomItemRamAnimation.deselectedColor
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = CustomItemRamAnimation.deselectedColor
    }
    
    override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        super.selectedState(icon, textLabel: textLabel)
        
        textLabel.textColor = CustomItemRamAnimation.selectedColor
        icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = CustomItemRamAnimation.selectedColor
    }
}
