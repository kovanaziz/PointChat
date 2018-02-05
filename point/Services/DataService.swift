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
    
    // ths func wil get userEmail for uid we passing to it.
    func getUsernameForUserId (forUID uid:String, handler: @escaping(_ username: String)->()) {
        REF_USERs.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
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
            handler(messageArray.reversed())
        }
    }
    
    func getEmail(forSeachQuery query:String, handler: @escaping (_ emailArray: [String]) -> ()){
        var emailArray = [String]()
        
        REF_USERs.observe(.value) { (userSnapshots) in
            guard let userSnapshots = userSnapshots.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshots {
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) == true && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
        handler(emailArray)
        }
    }
    
    func getuserId (forUsername usernames:[String], handler: @escaping (_ uidArray:[String]) -> ()) {
        var idArray = [String]()
        REF_USERs.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshots = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshots {
                let email = user.childSnapshot(forPath: "email").value as! String
                if usernames.contains(email){
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
    }
    
    func CreateGroup(withTitle title:String, andDescription description:String,forUserIds ids: [String], handler:@escaping (_ status:Bool)->()) {
        REF_GROUPS.childByAutoId().updateChildValues(["title" : title, "decription" : description, "members" : ids])
        handler(true) // even we can put some condition to know if we created group or not.
    }
}
