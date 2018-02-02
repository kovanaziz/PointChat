//
//  AuthService.swift
//  point
//
//  Created by John Smith on 2/2/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    static let instance = AuthService() // this will be live entire live of app and can bet get from anywhere in app
    
    func registerUser(withEmail email:String , andPassword password: String, userCreationComplete: @escaping (_ status : Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            
            let userData = ["provider" : user.providerID, "email":user.email]
            
            DataService.instance.createDBUSER(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email:String , andPassword password: String, loginComplete: @escaping (_ status : Bool, _ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                loginComplete(false, error)
                return
            }
            loginComplete(true, nil)
        }
    }
}
