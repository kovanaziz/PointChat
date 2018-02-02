//
//  MeVC.swift
//  point
//
//  Created by John Smith on 2/2/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let userEmail = Auth.auth().currentUser?.email else {return}
        emailLbl.text = userEmail
    }

    @IBAction func signOutBtnPressed(_ sender: Any) {
        //sigoutcode
    }
    

}
