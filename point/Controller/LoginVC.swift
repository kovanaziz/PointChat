//
//  LoginVC.swift
//  point
//
//  Created by John Smith on 1/22/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import UIKit

class LoginVC: UIViewController  {
 
    //outlet
    @IBOutlet weak var emailField: InsertTextFeild!
    @IBOutlet weak var passwordField: InsertTextFeild!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self

    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        
        if emailField.text != nil && passwordField.text != nil {
            // first we try to login, if we fail we will register the user, however in real world we should give the user the error rather login them, in this condition we shold have another page for registering, then after registering we can login the user.
            AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!, loginComplete: { (success, LoginError) in
                if success {
                     self.dismiss(animated: true, completion: nil)
                } else {
                    print(String(describing:LoginError?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, userCreationComplete: { (success, registerError) in
                    if success {
                        AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, loginComplete: { (success, nil) in
                            if success{
                                self.dismiss(animated: true, completion: nil)
                            } else {
                              print(String(describing:registerError?.localizedDescription))
                            }
                        })
                    }
                })
            })
        }
        
    }
    

    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}

extension LoginVC: UITextFieldDelegate {
    
}
