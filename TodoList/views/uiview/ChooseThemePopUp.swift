//
//  ChooseThemePopUp.swift
//  TodoList
//
//  Created by Adrien Audouard on 05/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import UIKit
import Spring

class ChooseThemePopUp: CustomXibSpringView {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var clearThemeButton: UIButton!
    @IBOutlet weak var darkThemeButton: UIButton!
    @IBOutlet weak var customThemeButton: UIButton!
    
    var delegate: ThemeChangeProtocol?
    
    override func setup() {
        super.setup()
        
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = 10
        
        for b in [clearThemeButton, darkThemeButton, customThemeButton] {
            b?.layer.masksToBounds = true
            b?.layer.cornerRadius = 20
            
            b?.layer.borderColor = b?.titleLabel?.textColor.cgColor
            b?.layer.borderWidth = 2
        }
        
    }
    
    @IBAction func changeThemeButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            delegate?.themeDidChange(theme: Theme.clear)
        case 1:
            delegate?.themeDidChange(theme: Theme.dark)
        default:
            delegate?.themeDidChange(theme: Theme.clear)
        }
        
        Animater.animate(self, animation: .FadeOut, curve: .EaseOut) {
            self.removeFromSuperview()
        }
    }
}
