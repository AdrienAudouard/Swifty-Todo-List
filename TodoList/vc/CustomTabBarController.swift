//
//  CustomTabBarController.swift
//  TodoList
//
//  Created by Adrien Audouard on 01/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class CustomTabBarController: RAMAnimatedTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setSelectIndex(from: 0, to: 1)
        //self.animationTabBarHidden(true)
        // Do any additional setup after loading the view.
    }
}
