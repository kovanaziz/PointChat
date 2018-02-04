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

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    @IBAction func doneBtnPressed(_ sender: Any) {
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else {
            return UITableViewCell()
        }
        let profileImage = UIImage(named: "defaultProfileImage")
        cell.configureCell(profileImage: profileImage!, email: "me@gmail.com", isSelected: true)
        return cell
    }
}
