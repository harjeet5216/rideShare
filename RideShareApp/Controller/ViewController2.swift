//
//  ViewController2.swift
//  RideShareApp
//
//  Created by Harjeet  on 1/3/19.
//  Copyright © 2019 Harjeet . All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController2: UIViewController {

    @IBAction func action(_ sender: UIButton) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "segue2", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
