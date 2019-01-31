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
  
    @IBOutlet weak var segControl: UISegmentedControl!
    
    let rideRef = Database.database().reference().child("rides")
    let riderRef = Database.database().reference().child("rider")
    var ride = [Ride]()
    var rider = [Rider]()
    
    @IBAction func segmentRide(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
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
        
        // download riders
        
        riderRef.observe(.value) { (snapshot) in
            self.rider.removeAll()
            
            for child in snapshot.children {
                let childSnapshot = child as! DataSnapshot
                let rider = Rider(snapshot: childSnapshot)
                self.rider.insert(rider, at: 0)
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 92.0
        self.tableView.rowHeight = UITableView.automaticDimension
//        let  newRider = Rider(origin: "Berkeley", destination: "Fresno", dateAndTime: "Thursday, January 1 2019")
//        newRider.save()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segControl.selectedSegmentIndex == 0 {
            return ride.count
        } else {
            return rider.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if segControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllRideCell", for: indexPath) as! RideTableViewCell
            let ride = self.ride[indexPath.row]
            
            cell.ride = ride
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableCell", for: indexPath) as! SecondTableViewCell
            let rider = self.rider[indexPath.row]
            
            cell.rider = rider
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let task = self.ride[indexPath.row]
            task.ref.removeValue()
        }
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        _ = self.ride[indexPath.row]
//        self.selectedTask = task
//        self.performSegue(withIdentifier: "postRide", sender: self)
//    }
}
