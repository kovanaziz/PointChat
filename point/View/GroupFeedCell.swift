//
//  GroupFeedCell.swift
//  point
//
//  Created by John Smith on 2/5/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    func configurecell(profileImg:UIImage, email:String, content:String) {
        self.profileImg.image = profileImg
        self.emailLbl.text = email
        self.contentLbl.text = content
    }

}
