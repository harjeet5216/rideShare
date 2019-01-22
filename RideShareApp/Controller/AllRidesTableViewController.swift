//
//  File.swift
//  RideShareApp
//
//  Created by Harjeet  on 1/7/19.
//  Copyright © 2019 Harjeet . All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class AllRidesTableViewController: UITableViewController {
    
    let rideRef = Database.database().reference().child("rides").queryOrdered(byChild: "origin")
    var ride = [Ride]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // download rides
    
        rideRef.observe(.value) { (snapshot) in
            self.ride.removeAll()
            
            for child in snapshot.children {
                let childSnapshot = child as! DataSnapshot
                let ride = Ride(snapshot: childSnapshot)
                self.ride.insert(ride, at: 0)
            }
            self.tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 92.0
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ride.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllRideCell", for: indexPath) as! RideTableViewCell
        let ride = self.ride[indexPath.row]
        
        cell.ride = ride
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let task = self.ride[indexPath.row]
            task.ref.removeValue()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = self.ride[indexPath.row]
       // self.selectedTask = task
       // self.performSegue(withIdentifier: "postRide", sender: self)
    }
}
