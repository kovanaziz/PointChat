//
//  Group.swift
//  point
//
//  Created by John Smith on 2/5/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import Foundation

class Group {
    
    private var _groupTitle : String
    private var _grouDescription : String
    private var _members : [String]
    private var _memberCount : Int
    private var _key : String
    
    var title : String {
        return _groupTitle
    }
    
    var description:String {
        return _grouDescription
    }
    
    var members:[String] {
        return _members
    }
    
    var memberNumber:Int {
        return _memberCount
    }
    
    var key:String {
        return _key
    }
    
    init(title :String, description:String, key:String, members:[String]) {
        self._groupTitle = title
        self._grouDescription = description
        self._members = members
        self._memberCount = members.count
        self._key = key
    }
    
}
