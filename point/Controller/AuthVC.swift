//
//  AuthVC.swift
//  point
//
//  Created by John Smith on 1/22/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FacebookCore
import FacebookLogin

class AuthVC: UIViewController {
    
    //Outlet
    @IBOutlet weak var facebookLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookLoginBtn.addTarget(self, action: #selector(handleCustomFDLogin), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func handleCustomFDLogin() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ .publicProfile, .email], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success:
                let accessToken = AccessToken.current
                guard let accesTokenString = accessToken?.authenticationToken else {return}
                let credentials = FacebookAuthProvider.credential(withAccessToken: accesTokenString)
                
                Auth.auth().signIn(with: credentials, completion: { (user, error) in
                    if let err = error {
                        print("Something went wrong with user: \(err.localizedDescription)")
                        return
                    }
                    // test this for more concrete result before using it.
                    DataService.instance.createDBUSER(uid: (user?.uid)!, userData: ["provider":"Facebook","email":user?.email])
                })
               self.dismiss(animated: true, completion: nil)
            }
            
       }
    }
    
//    func showEmailAddress()   {
//        let req = GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"], accessToken:AccessToken.current, httpMethod: .GET, apiVersion: .defaultVersion)
//        req.start { (connection, result) in
//            print(result)
//        }
//    }
    
    // after login, if we logged in then this windows should disappear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func signinWithEmailBtnPressed(_ sender: Any) {
        
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
        
    }
    
    @IBAction func googleSignInBtnPressed(_ sender: Any) {
    }
    
    @IBAction func facebookSignInBtnPressed(_ sender: Any) {
    }
    
    
}
