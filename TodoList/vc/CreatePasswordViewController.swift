//
//  CreatePasswordViewController.swift
//  TodoList
//
//  Created by Adrien Audouard on 09/03/2018.
//  Copyright © 2018 Adrien Audouard. All rights reserved.
//

import UIKit
import LocalAuthentication

class CreatePasswordViewController: UIViewController {

    @IBOutlet weak var underTFView: NSLayoutConstraint!
    @IBOutlet weak var createPasswordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func hideShowButtonPressed(_ sender: UIButton) {
        createPasswordTF.isSecureTextEntry = !createPasswordTF.isSecureTextEntry
        sender.setTitle(createPasswordTF.isSecureTextEntry ? "show" : "hide", for: .normal)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
        guard createPasswordTF.text! != "" else {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "InitListViewController", sender: nil)
            }
            
            return
        }
        
        AppPreferences.sharedInstance.password = createPasswordTF.text!
        
        let authContext = LAContext()
        
        var error: NSError?
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let popUp = TouchIdPopUP(frame: self.view.bounds)
            
            popUp.present(view: self.view, callback: { [unowned self] (succes) in
                AppPreferences.sharedInstance.useTouchId = succes
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "InitListViewController", sender: nil)
                }
            })
        } else {
            self.performSegue(withIdentifier: "InitListViewController", sender: nil)
        }
        
    }
}
