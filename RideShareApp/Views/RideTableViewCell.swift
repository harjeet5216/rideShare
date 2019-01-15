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
    @IBOutlet weak var originInfo: UILabel!
    @IBOutlet weak var destinationInfo: UILabel!
    @IBOutlet weak var fareInfo: UITextField!
    @IBOutlet weak var seatInfo: UITextField!
    
    var ride: Ride! {
        didSet {
            originInfo.text = ride.origin
            destinationInfo.text = ride.destination
            fareInfo.text = ride.fare
            seatInfo.text = ride.seats
        }
    }
    
}
