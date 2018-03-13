//
//  Animater.swift
//  SmartBike
//
//  Created by Adrien Audouard on 16/04/2017.
//  Copyright © 2017 Adrien Audouard. All rights reserved.
//

import Foundation
import Spring

class Animater {
    public static func animate(_ sender: Springable, animation: Spring.AnimationPreset, curve: Spring.AnimationCurve, duration: CGFloat = 1.0, callback: @escaping () -> Void) {
        
            let selectedForce: CGFloat = 1
            let selectedDuration: CGFloat = duration
            let selectedDelay: CGFloat = 0
            
            let selectedDamping: CGFloat = 0.7
            let selectedVelocity: CGFloat = 0.7
            let selectedScale: CGFloat = 1
            let selectedX: CGFloat = 0
            let selectedY: CGFloat = 0
            let selectedRotate: CGFloat = 0
            
            sender.force = selectedForce
            sender.duration = selectedDuration
            sender.delay = selectedDelay
            
            sender.damping = selectedDamping
            sender.velocity = selectedVelocity
            sender.scaleX = selectedScale
            sender.scaleY = selectedScale
            sender.x = selectedX
            sender.y = selectedY
            sender.rotate = selectedRotate
            
            sender.animation = animation.rawValue
            sender.curve = curve.rawValue
            sender.animateNext(completion: callback)
            //sender.animate()
    }
    
    public static func animate(_ sender: Springable, animation: Spring.AnimationPreset, curve: Spring.AnimationCurve, duration: CGFloat = 1.0) {
        
        self.animate(sender, animation: animation, curve: curve, duration: duration) {
        }
        
    }
}
