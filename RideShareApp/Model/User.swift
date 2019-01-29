//
//  User.swift
//  RideShareApp
//
//  Created by Harjeet  on 1/22/19.
//  Copyright © 2019 Harjeet . All rights reserved.
//

import Foundation
import UIKit
import Firebase

class User: NSObject {
    var displayName: String?
    var email: String?
    var userName: String?
    var profileImageUrl: String?
    
    let ref: DatabaseReference!
    
    init(dictionary: [AnyHashable: Any]) {
        self.displayName = dictionary["displayName"] as? String
        self.email = dictionary["email"] as? String
        self.userName = dictionary["userName"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
        
        ref = Database.database().reference().child("users").childByAutoId()
    }
    
    func save() {
        ref.setValue(toDictionary())
    }
    
    func toDictionary() -> [String : Any] {
        return [
            "displayName" : displayName as Any,
            "email" : email as Any,
            "userName" : userName as Any,
            "profileImageUrl" : profileImageUrl as Any
        ]
    }
}
