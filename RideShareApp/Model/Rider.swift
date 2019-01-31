//
//  Rider.swift
//  RideShareApp
//
//  Created by Harjeet  on 1/29/19.
//  Copyright © 2019 Harjeet . All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Rider  {
    var userUid: String = Auth.auth().currentUser!.uid
    var origin: String = ""
    var destination: String = ""
    var dateAndTime: String = ""
    var createdAt: NSNumber = NSNumber(value: Int(NSDate().timeIntervalSince1970))
    
    
    let ref: DatabaseReference!
    
    
    init(origin: String, destination: String, dateAndTime: String) {
        self.origin = origin
        self.destination = destination
        self.dateAndTime = dateAndTime
        ref = Database.database().reference().child("rider").childByAutoId()
    }
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        if let value = snapshot.value as? [String : Any] {
            origin = value["origin"] as! String
            destination = value["destination"] as! String
            dateAndTime = value["dateAndTime"] as! String
            userUid = value["userUid"] as! String
            createdAt = value["createdAt"] as! NSNumber
        }
    }
    
    func save() {
        ref.setValue(toDictionary())
    }
    
    func toDictionary() -> [String : Any] {
        return [
            "origin" : origin,
            "destination" : destination,
            "dateAndTime" : dateAndTime,
            "userUid" : userUid,
            "createdAt" : createdAt
        ]
    }
}
