//
//  FirstViewController.swift
//  point
//
//  Created by John Smith on 1/22/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    //Outlet
    @IBOutlet weak var tableView: UITableView!
    
    //Varibale
    var messageArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // before view didload this data will be loaded
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataService.instance.getAllFeedMessages { (returnedMessagedArray) in
            self.messageArray = returnedMessagedArray
            self.tableView.reloadData()
        }
    }

}

extension FeedVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else {return UITableViewCell()}
        let image = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row]
        
        DataService.instance.getUsernameForUserId(forUID: message.senderID) { (returnedUsername) in
            cell.configureCell(profileimage: image!, email: returnedUsername, content: message.content)
        }
        return cell
    }
}
