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

class Ride {
    var origin: String = ""
    var destination: String = ""
    var seats: String = ""
    var fare: String = ""
    //var date: UIDatePicker.Mode { ge
    
    let ref: DatabaseReference!
    
    init(origin: String, destination: String, seats: String, fare: String) {
        self.origin = origin
        self.destination = destination
        self.seats = seats
        self.fare = fare
       // self.date = date
        ref = Database.database().reference().child("rides").childByAutoId()
    }
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        if let value = snapshot.value as? [String : Any] {
            origin = value["origin"] as! String
            destination = value["destination"] as! String
            seats = value["seats"] as! String
            fare = value["fare"] as! String
           // date = value["date"] as! UIDatePicker.Mode
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
            "fare" : fare
            // "date" : date
        ]
    }
}

