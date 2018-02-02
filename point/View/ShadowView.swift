//
//  ShadowView.swift
//  point
//
//  Created by John Smith on 1/22/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = #colorLiteral(red: 0.1118396893, green: 0.1118396893, blue: 0.1118396893, alpha: 1)
    }

}
