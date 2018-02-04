//
//  UserCell.swift
//  point
//
//  Created by John Smith on 2/4/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    //Outlet
    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    
    //Variable
    var showing = false
    
    
    func configureCell(profileImage image:UIImage, email:String, isSelected:Bool){
        self.userProfileImg.image = image
        self.userEmailLbl.text = email
        
        if isSelected {
            checkImg.isHidden = false
        } else {
            checkImg.isHidden = true
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            if showing == false {
                checkImg.isHidden = false
                showing = true
            } else {
                checkImg.isHidden = true
                showing = false
            }
        }

    }

}
