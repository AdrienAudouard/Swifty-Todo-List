//
//  LoadingViewController.swift
//  TodoList
//
//  Created by Adrien Audouard on 01/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit
import Spring

class LoadingViewController: UIViewController {

    @IBOutlet weak var loadingImage: SpringImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Animater.animate(loadingImage, animation: .Fall, curve: .EaseIn, duration: 0.5) {
            if AppPreferences.sharedInstance.firstLaunch {
                self.performSegue(withIdentifier: "CreatePasswordViewController", sender: nil)
            } else if AppPreferences.sharedInstance.usePassword {
                self.performSegue(withIdentifier: "AuthentificationViewController", sender: nil)
            } else {
                self.performSegue(withIdentifier: "CustomTabBarController", sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
