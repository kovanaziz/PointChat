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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupTableView.delegate = self
        groupTableView.dataSource = self
    }


}

extension GroupVC: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupTableView.dequeueReusableCell(withIdentifier: "GroupCell") as? GroupCell else {return UITableViewCell()}
        cell.configureCell(withGroupTitle: "comehere", andDescription: "justforTesr", memberNumber: 12)
        return cell
    }
    
}

