//
//  CustomMainItemRamAnimation.swift
//  TodoList
//
//  Created by Adrien Audouard on 09/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import RAMAnimatedTabBarController

class CustomMainItemRamAnimation: RAMBounceAnimation {
    
    override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        super.playAnimation(icon, textLabel: textLabel)
        
        icon.image = icon.image?.withRenderingMode(.alwaysOriginal)
    }
    
    override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
        super.deselectAnimation(icon, textLabel: textLabel, defaultTextColor: defaultTextColor, defaultIconColor: defaultIconColor)
        
        icon.image = icon.image?.withRenderingMode(.alwaysOriginal)
    }
    
    override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        super.selectedState(icon, textLabel: textLabel)
        
        icon.image = icon.image?.withRenderingMode(.alwaysOriginal)
    }
}
