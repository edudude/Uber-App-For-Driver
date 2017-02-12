//
//  SignInVC.swift
//  Uber App For Driver
//
//  Created by Jeff Kral on 12/12/16.
//  Copyright © 2016 Jeff Kral. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {
    
    private let DRIVER_SEGUE = "DriverVC"
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logIn(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            AuthProvider.Instance.login(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
                
                if message != nil {
                    self.alertTheUser(title: "Problem With Authentication", message: message!)
                } else {
                    UberHandler.Instance.driver = self.emailTextField.text!
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: self.DRIVER_SEGUE, sender: nil)
                }
            })
        } else {
            alertTheUser(title: "Email and Password are required", message: "Please enter email and password in the text fields")
        }
    }
    
    @IBAction func SignUp(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            AuthProvider.Instance.signUp(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
                
                if message != nil {
                    self.alertTheUser(title: "Problem with creating a new user", message: message!)
                } else {
                    UberHandler.Instance.driver = self.emailTextField.text!
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: self.DRIVER_SEGUE, sender: nil)
                }
            })
            
        } else {
            alertTheUser(title: "Email and Password are required", message: "Please enter email and password in the text fields")
        }
    }
    
   private func alertTheUser(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

}
