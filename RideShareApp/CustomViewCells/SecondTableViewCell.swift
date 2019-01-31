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
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var dateAndTime: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var destination: UILabel!
    
    
    var rider: Rider! {
        didSet {
            userName.text = "Sample"
            dateAndTime.text = rider.dateAndTime
            origin.text = rider.origin
            destination.text = rider.destination
            timeAgo.text = Date(timeIntervalSince1970: TimeInterval(truncating: rider.createdAt)).timeAgoSinceDate()
        }
    }
}
