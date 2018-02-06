//
//  GroupFeedVC.swift
//  point
//
//  Created by John Smith on 2/5/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import UIKit
import Firebase

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
    var groupMessages = [Message]()
    
    func initData(forGroup group:Group){
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtnView.bindToKeyboard()
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleLbl.text = group?.title
        DataService.instance.getEmailFor(group: group!) { (returnedEmails) in
            self.membesLbl.text = returnedEmails.joined(separator: ", ")
        }
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (returnedGroupMessages) in
                self.groupMessages = returnedGroupMessages
                self.tableView.reloadData()
                // scroll table view to the last message
                if self.groupMessages.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath(row:self.groupMessages.count - 1,section: 0), at: .none, animated: true)
                }
            })
        }
    }

    @IBAction func sendBtnPressed(_ sender: Any) {
        if sendTextField.text != "" {
            sendTextField.isEnabled = false
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: sendTextField.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.key, sendComplete: { (success) in
                if success {
                    self.sendTextField.isEnabled = true
                    self.sendBtn.isEnabled = true
                    self.sendTextField.text = ""
                }
            })
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismissDetail()
    }

}

extension GroupFeedVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupFeedCell", for: indexPath) as? GroupFeedCell else {return UITableViewCell()}
        let message = groupMessages[indexPath.row]
        
        DataService.instance.getUsernameForUserId(forUID: message.senderID) { (email) in
            cell.configurecell(profileImg: UIImage(named: "defaultProfileImage")!, email: email, content: message.content)
        }
        return cell
    }
}
