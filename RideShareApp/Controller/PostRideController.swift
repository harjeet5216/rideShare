//
//  PostRideController.swift
//  RideShareApp
//
//  Created by Harjeet  on 1/11/19.
//  Copyright © 2019 Harjeet . All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PostRideController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var origin: UITextField!
    @IBOutlet weak var destination: UITextField!
    @IBOutlet weak var seats: UITextField!
    @IBOutlet weak var fare: UITextField!
    @IBOutlet weak var date: UIDatePicker?

    @IBAction func postRide(_ sender: Any) {

        let newRide = Ride(origin: origin.text!, destination: destination.text!, seats: seats.text!, fare: fare.text!)
        newRide.save()
        self.navigationController!.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
