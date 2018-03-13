//
//  SettingsViewController.swift
//  TodoList
//
//  Created by Adrien Audouard on 09/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit
import LocalAuthentication

class SettingsViewController: UIViewController {

    @IBOutlet weak var nightModeSwitch: UISwitch!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var removePasswordButton: UIButton!
    @IBOutlet weak var touchIDSwitch: UISwitch!
    
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        versionLabel.text = "Version \(version())"
        touchIDSwitch.setOn(AppPreferences.sharedInstance.useTouchId, animated: false)
        
        removePasswordButton.setTitle(AppPreferences.sharedInstance.usePassword ? "Remove the password" : "Use a password", for: .normal)
    }
    
    func version() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        return version
    }
    
    func removePassword() {
        alertWithTextField(title: "Remove the password", message: "Please enter the password to confirm", placeholder: "Enter the password") { (tfs) in
            let text = tfs[0].text!
            
            if text == AppPreferences.sharedInstance.password {
                self.touchIDSwitch.setOn(false, animated: true)
                AppPreferences.sharedInstance.password = ""
                AppPreferences.sharedInstance.useTouchId = false
                self.removePasswordButton.setTitle("Use a password", for: .normal)
            }
        }
    }
    
    func activatePassword() {
        alertWithTextField(title: "Use a password", message: "Enter a password", placeholder: "Enter a password") { (tfs) in
            let text = tfs[0].text!
            
            if text != "" {
                self.removePasswordButton.setTitle("Remove the password", for: .normal)
                AppPreferences.sharedInstance.password = text
            }
        }
    }
    
    func alertWithTextField(title: String, message: String, placeholder: String, callback: @escaping ([UITextField]) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { (tf) in
            tf.placeholder = placeholder
            tf.isSecureTextEntry = true
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            callback((alert?.textFields!)!)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorAlert(_ message: String) {
        alert(title: "Error", message: message, button: "Cancel")
    }
    
    @IBAction func touchIDSwiftValueChanged(_ sender: UISwitch) {
        let authentificationContext = LAContext()
        var error: NSError?
        
        guard authentificationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            self.errorAlert("You can not use touch ID on this device")
            return
        }
        
        let msg = !sender.isOn ? "Desactivate touch ID" : "Activate touch ID"
        
        authentificationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: msg) { [unowned self] (success, error) in
            
            DispatchQueue.main.async { 
                if success {
                    AppPreferences.sharedInstance.useTouchId = sender.isOn
                } else {
                    let errorMSG = !sender.isOn ? "Error when desactivating touch ID" : "Error when activating touch ID"
                    sender.setOn(!sender.isOn, animated: true)
                    self.errorAlert(errorMSG)
                }
            }
        }
        
        AppPreferences.sharedInstance.useTouchId = sender.isOn
    }
    
    @IBAction func removePasswordButtonPressed(_ sender: Any) {
        if AppPreferences.sharedInstance.usePassword {
            removePassword()
        } else {
            activatePassword()
        }
    }

}
