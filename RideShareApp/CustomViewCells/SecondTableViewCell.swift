//
//  secondTableViewCell.swift
//  RideShareApp
//
//  Created by Harjeet  on 1/29/19.
//  Copyright © 2019 Harjeet . All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SecondTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dataInfo: UILabel!
    
    
    
    var rider: Rider! {
        didSet {
            dataInfo.text = rider.displayName
        }
    }
}
