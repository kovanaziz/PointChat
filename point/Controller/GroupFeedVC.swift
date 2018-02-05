//
//  GroupFeedVC.swift
//  point
//
//  Created by John Smith on 2/5/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {
    
    //Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var membesLbl: UILabel!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var sendTextField: InsertTextFeild!
    @IBOutlet weak var sendBtn: UIButton!
    
    //Variable
    var group :Group?
    
    func initData(forGroup group:Group){
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtnView.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleLbl.text = group?.title
        DataService.instance.getEmailFor(group: group!) { (returnedEmails) in
            self.membesLbl.text = returnedEmails.joined(separator: ", ")
        }
        
    }

    @IBAction func sendBtnPressed(_ sender: Any) {
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
