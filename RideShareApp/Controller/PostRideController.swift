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
import GoogleSignIn

class PostRideController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var origin: UITextField!
    @IBOutlet weak var destination: UITextField!
    @IBOutlet weak var seats: UITextField!
    @IBOutlet weak var fare: UITextField!
    @IBOutlet weak var inputTextField: UITextField!
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        datePicker?.addTarget(self, action: #selector(PostRideController.dateChanged(datePicker:)), for: .valueChanged)
        
        inputTextField.inputView = datePicker
    }
    
    
    @IBAction func signOut(_ sender: Any) {
       
            try! Auth.auth().signOut()
            try! GIDSignIn.sharedInstance()?.signOut()
            self.dismiss(animated: true, completion: nil)
        }
    @IBAction func postRide(_ sender: Any) {
        let newRide = Ride(origin: origin.text!, destination: destination.text!, seats: seats.text!, fare: fare.text!, dateAndTime: inputTextField.text!)
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
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d yyyy h:mm a"
        inputTextField.text = dateFormatter.string(from: datePicker.date)

    }
}
