//
//  SecondViewController.swift
//  point
//
//  Created by John Smith on 1/22/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import UIKit

class GroupVC: UIViewController {

    //Outlet
    @IBOutlet weak var groupTableView: UITableView!
    
    //Variable
    var groupArray = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupTableView.delegate = self
        groupTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // this will observe for any change in group and modified accordingly.
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getGroup { (returnedGroupAAray) in
                self.groupArray = returnedGroupAAray
                self.groupTableView.reloadData()
            }
            
        }
        
    }


}

extension GroupVC: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupTableView.dequeueReusableCell(withIdentifier: "GroupCell") as? GroupCell else {return UITableViewCell()}
        let group = groupArray[indexPath.row]
        cell.configureCell(withGroupTitle: group.title , andDescription: group.description , memberNumber: group.memberNumber)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else {return}
        let group = groupArray[indexPath.row]
        groupFeedVC.initData(forGroup: group)
        present(groupFeedVC, animated: true, completion: nil)
    }
    
}

