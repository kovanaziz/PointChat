//
//  CreateGroupVC.swift
//  point
//
//  Created by John Smith on 2/4/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import UIKit

class CreateGroupVC: UIViewController {

    //Outlet
    @IBOutlet weak var titleTextField: InsertTextFeild!
    @IBOutlet weak var descriptionTitleField: InsertTextFeild!
    @IBOutlet weak var emailSearchTextField: InsertTextFeild!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var groupMemberLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func doneBtnPressed(_ sender: Any) {
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
    }
    
}
