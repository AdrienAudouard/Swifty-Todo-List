//
//  TouchIdPopUP.swift
//  TodoList
//
//  Created by Adrien Audouard on 09/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import Foundation
import UIKit

class TouchIdPopUP: CustomXibSpringView {
    
    typealias ResultCallback = (Bool) -> Void
    
    @IBOutlet weak var roundedBackgroundVew: UIView!
    
    var callback: ResultCallback?
    
    override func setup() {
        super.setup()
        
        roundedBackgroundVew.layer.masksToBounds = true
        roundedBackgroundVew.layer.cornerRadius = 8
    }
    
    func present(view: UIView, callback: @escaping ResultCallback) {
        self.bounds = view.bounds
        view.addSubview(self)
        
        Animater.animate(self, animation: .FadeIn, curve: .EaseIn, duration: 0.2)
        
        self.callback = callback
    }
    
    @IBAction func resultButtonPressed(sender: UIButton) {
        self.callback?(sender.tag == 1)
        Animater.animate(self, animation: .FadeOut, curve: .EaseOut, duration: 0.2) {
            self.removeFromSuperview()
        }
        
    }
}
