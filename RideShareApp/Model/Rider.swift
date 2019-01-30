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
    var displayName: String = ""
    var email: String = ""
    
    let ref: DatabaseReference!
    
    
    init(displayName: String, email: String) {
        self.displayName = displayName
        self.email = email
        ref = Database.database().reference().child("rider")
    }
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        if let value = snapshot.value as? [String : Any] {
            displayName = value["displayName"] as! String
            email = value["email"] as! String
        }
    }
}
