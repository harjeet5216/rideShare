//
//  User.swift
//  RideShareApp
//
//  Created by Harjeet  on 1/22/19.
//  Copyright © 2019 Harjeet . All rights reserved.
//

import Foundation
import UIKit

class User: NSObject {
    var displayName: String?
    var email: String?
    var userName: String?
    var profileImageUrl: String?
    
    init(dictionary: [AnyHashable: Any]) {
        self.displayName = dictionary["displayName"] as? String
        self.email = dictionary["email"] as? String
        self.userName = dictionary["userName"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
}
