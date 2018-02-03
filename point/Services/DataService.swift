//
//  DataService.swift
//  point
//
//  Created by John Smith on 1/22/18.
//  Copyright © 2018 John Smith. All rights reserved.
//

import Foundation
import Firebase

// base url for database
let DB_BASE = Database.database().reference()

class DataService {
    
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE : DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERs : DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS : DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED : DatabaseReference {
        return _REF_FEED
    }
    
    // this func can be used to create firebase users
    func createDBUSER(uid:String, userData: Dictionary<String,Any>) {
        REF_USERs.child(uid).updateChildValues(userData) // inside "users" we create new child
        
    }
    
    // this func will put message in 
    func uploadPost(withMessage message:String, forUID uid:String, withGroupKey groupKey:String?, sendComplete: @escaping (_ status:Bool) -> ()) {
        if groupKey !=  nil {
            // send to groupred
            } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderID": uid])
            sendComplete(true)
        }
    }
    
    func getAllFeedMessages(handler: @escaping(_ message: [Message]) -> ()) {
        
        var messageArray = [Message]()
        
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapShot) in
            guard let feedMessageSnapShot = feedMessageSnapShot.children.allObjects as? [DataSnapshot] else {return}
            for message in feedMessageSnapShot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderID").value as! String
                let message = Message(content: content, senderID: senderId)
                messageArray.append(message)
            }
            handler(messageArray)
        }
    }
}
