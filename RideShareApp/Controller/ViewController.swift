//
//  ViewController.swift
//  RideShareApp
//
//  Created by Harjeet  on 1/3/19.
//  Copyright © 2019 Harjeet . All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBAction func action(_ sender: UIButton) {
        if emailText.text != "" && passwordText.text != ""
        {
            if segmentControl.selectedSegmentIndex == 0
            {
                // login user
                Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!, completion: { (user,error) in
                    if user != nil {
                        self.performSegue(withIdentifier: "show", sender: self)
                    } else {
                        print(error!)
                    }
                })
            } else {
                Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                    if user != nil {
                        self.performSegue(withIdentifier: "show", sender: self)
                    } else {
                        print(error!)
                    }
                }
            }
        }
    }
    
    
    @IBAction func anonymouslyButton(_ sender: Any) {
        Auth.auth().signInAnonymously { (user, error) in
            if error == nil {
                self.performSegue(withIdentifier: "show", sender: self)
            }   else {
                print(error!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func handleSelectProfileImageView() {
        print("Hello, how are you ? ")
    }
    
}
