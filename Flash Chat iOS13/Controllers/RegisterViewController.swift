//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Сергей Кривошапко on 15.06.2021.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    deinit {
        print("RegisterViewController was deinit")
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    
                } else {
                    //GoToChatVC
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
        
       
    }
    
}
