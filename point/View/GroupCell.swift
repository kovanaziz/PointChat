//
//  GroupCell.swift
//  point
//
//  Created by John Smith on 2/5/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var memberNumber: UILabel!
    
    func configureCell(withGroupTitle title : String, andDescription desc:String, memberNumber: Int){
        self.groupTitle.text = title
        self.groupDescription.text = desc
        self.memberNumber.text = "\(memberNumber) members"
    }
}
