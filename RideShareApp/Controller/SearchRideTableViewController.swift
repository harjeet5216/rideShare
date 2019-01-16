//
//  SearchRideTableViewController.swift
//  RideShareApp
//
//  Created by Harjeet  on 1/15/19.
//  Copyright © 2019 Harjeet . All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchRideTableViewController: UITableViewController, UISearchResultsUpdating {

    @IBOutlet var filterUserTableView: UITableView!
    
    let rideSearch = UISearchController(searchResultsController: nil)
    var rideArray = [NSDictionary?]()
    var filterRide = [NSDictionary?]()
    var databaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rideSearch.searchResultsUpdater = self
        rideSearch.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = rideSearch.searchBar
        
        databaseRef.child("rides").queryOrdered(byChild: "origin").observe(.childAdded) { (snapshot) in
            self.rideArray.append(snapshot.value as? NSDictionary)
            
            // insert the rows
            
            self.filterUserTableView.insertRows(at: [IndexPath(row:self.rideArray.count-1, section: 0)], with: UITableView.RowAnimation.automatic)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if rideSearch.isActive && rideSearch.searchBar.text != "" {
            return filterRide.count
        }
        return self.rideArray.count
    }

    @IBAction func dismissSearch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(searchText: self.rideSearch.searchBar.text!)
    }
    
    func filterContent(searchText: String) {
        self.filterRide = self.rideArray.filter{ user in
            let rideName = user!["origin"] as! String
            return(rideName.lowercased().contains(searchText.lowercased()))
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        let ride : NSDictionary?

        if rideSearch.isActive && rideSearch.searchBar.text != "" {
           ride = filterRide[indexPath.row]
        } else {
            ride = self.rideArray[indexPath.row]
        }
        
        cell.textLabel?.text = ride?["origin"] as? String
       // cell.detailTextLabel?.text = ride?["handle"] as? String

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
