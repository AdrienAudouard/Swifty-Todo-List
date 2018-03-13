//
//  AuthentificationViewController.swift
//  TodoList
//
//  Created by Adrien Audouard on 09/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit
import LocalAuthentication
import Spring

class AuthentificationViewController: UIViewController {

    @IBOutlet weak var hideShowButton: SpringButton!
    @IBOutlet weak var passwordTFBarView: SpringView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTF: SpringTextField!
    @IBOutlet weak var touchIdButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let authentificationContext = LAContext()
        var error: NSError?
        
        if !authentificationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) || !AppPreferences.sharedInstance.useTouchId  {
            touchIdButton.isHidden = true
        } else {
            touchIDLogin()
        }
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func touchIDLogin() {
        let authentificationContext = LAContext()
        
        authentificationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Login with touch ID") { (success, error) in
            if success {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "CustomTabBarController", sender: nil)
                }
            } else {
                print("error")
            }
        }
    }
    
    @IBAction func showHideButtonPressed(_ sender: UIButton) {
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
        sender.setTitle(passwordTF.isSecureTextEntry ? "show" : "hide", for: .normal)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if passwordTF.text == AppPreferences.sharedInstance.password {
            self.performSegue(withIdentifier: "CustomTabBarController", sender: nil)
        } else {
            errorLabel.text = "Wrong password !"
            passwordTF.text = ""
            
            Animater.animate(hideShowButton, animation: .Shake, curve: .EaseIn, duration: 0.7)
            Animater.animate(passwordTFBarView, animation: .Shake, curve: .EaseIn, duration: 0.7)
            Animater.animate(passwordTF, animation: .Shake, curve: .EaseIn, duration: 0.7)
        }
    }
    
    @IBAction func touchIdButtonPressed(_ sender: Any) {
        touchIDLogin()
    }
}
