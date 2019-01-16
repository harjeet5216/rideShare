//
//  RideTableViewCell.swift
//  RideShareApp
//
//  Created by Harjeet  on 1/13/19.
//  Copyright © 2019 Harjeet . All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RideTableViewCell: UITableViewCell {
    @IBOutlet weak var dateAndTime: UILabel!
    @IBOutlet weak var originInfo: UILabel!
    @IBOutlet weak var destinationInfo: UILabel!
    @IBOutlet weak var seatsInfo: UILabel!   
    @IBOutlet weak var fareInfo: UILabel!
    
    var ride: Ride! {
        didSet {
            dateAndTime.text = ride.dateAndTime
            originInfo.text = ride.origin
            destinationInfo.text = ride.destination
            fareInfo.text = ride.fare
            seatsInfo.text = ride.seats
        }
    }
    
}
