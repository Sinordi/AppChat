//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Сергей Кривошапко on 15.06.2021.
//
import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    deinit {
        print("LoginViewController was deinit")
    }
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
              
             
            }
        }
    }
    
}
