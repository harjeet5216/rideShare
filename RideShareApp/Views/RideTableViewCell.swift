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
  
    @IBOutlet weak var imageU: UIImageView!
    
    let userRef = Database.database().reference()
    
    var ride: Ride! {
        didSet {
            
            let tempUid = ride.userUid
            
            print("##### \(tempUid)")
            
            let sharedSession = URLSession.shared
            
            if let url = URL(string: "https://goo.gl/wV9G4I") {
                // Create Request
                let request = URLRequest(url: url)
                
                // Create Data Task
                let dataTask = sharedSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.imageU.image = image
                        }
                    }
                })
                
                dataTask.resume()
            }
            
            
            dateAndTime.text = ride.userUid
            originInfo.text = ride.origin
            destinationInfo.text = ride.destination
            fareInfo.text = ride.fare
            seatsInfo.text = ride.seats
        }
    }
    
}


// Added this line to commit messages

