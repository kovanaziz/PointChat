//
//  FeedCell.swift
//  point
//
//  Created by John Smith on 2/2/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var contentMessageLbl: UILabel!
    
    func configureCell(profileimage: UIImage, email :String, content:String) {
        self.profileImage.image = profileimage
        self.userEmailLbl.text = email
        self.contentMessageLbl.text = content
    }
    
}
