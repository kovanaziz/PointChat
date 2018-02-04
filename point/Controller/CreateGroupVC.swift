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
    
    //Variable
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        titleTextField.delegate = self
        descriptionTitleField.delegate = self
        emailSearchTextField.delegate = self
        
        
        emailSearchTextField.addTarget(self, action: #selector (textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
    @objc func textFieldDidChange(){
        if emailSearchTextField.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSeachQuery: emailSearchTextField.text!, handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            })
        }
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
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else {
            return UITableViewCell()
        }
        let profileImage = UIImage(named: "defaultProfileImage")
        
        if chosenUserArray.contains(emailArray[indexPath.row]) {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else {return}
        if !chosenUserArray.contains(cell.userEmailLbl.text!) {
            chosenUserArray.append(cell.userEmailLbl.text!)
            groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        } else {
            chosenUserArray = chosenUserArray.filter({$0 != cell.userEmailLbl.text})
            if chosenUserArray.count >= 1 {
               groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            } else {
                groupMemberLbl.text = "add people to your group"
                doneBtn.isHidden = true
            }
        }
    }
}

extension CreateGroupVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == titleTextField {
          titleTextField.text = ""
        } else if textField == descriptionTitleField {
          descriptionTitleField.text = ""
        } else {
          emailSearchTextField.text = ""
        }
    }
    
    // if nothing wirte down after edting, then the defualt text will added to the textfield.
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == titleTextField {
            if titleTextField.text == "" {
                titleTextField.text = "give your group a title"
            }
        } else if textField == descriptionTitleField {
            if descriptionTitleField.text == "" {
                descriptionTitleField.text = "give your group a description"
            }
        } else {
            if emailSearchTextField.text == "" {
                emailSearchTextField.text = "enter an email"
            }
        }
    }
}
