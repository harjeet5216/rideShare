//
//  Ride.swift
//  RideShareApp
//
//  Created by Harjeet  on 1/10/19.
//  Copyright © 2019 Harjeet . All rights reserved.
//
import UIKit
import Foundation
import Firebase
import GoogleSignIn

class Ride {
    var userUid: String = Auth.auth().currentUser!.uid
    var origin: String = ""
    var destination: String = ""
    var seats: String = ""
    var fare: String = ""
    var dateAndTime: String = ""
    var createdAt: NSNumber = NSNumber(value: Int(NSDate().timeIntervalSince1970))
    
    let ref: DatabaseReference!
    
    init(origin: String, destination: String, seats: String, fare: String, dateAndTime: String) {
        self.origin = origin
        self.destination = destination
        self.seats = seats
        self.fare = fare
        self.dateAndTime = dateAndTime
        // self.userUid = Auth.auth().currentUser!.uid
        ref = Database.database().reference().child("rides").childByAutoId()
    }
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        if let value = snapshot.value as? [String : Any] {
            origin = value["origin"] as! String
            destination = value["destination"] as! String
            seats = value["seats"] as! String
            fare = value["fare"] as! String
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
            "seats" : seats,
            "fare" : fare,
            "dateAndTime" : dateAndTime,
            "userUid" : userUid,
            "createdAt" : createdAt
        ]
    }
}

