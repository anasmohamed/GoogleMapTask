//
//  SavedLocationsTableTableViewController.swift
//  GoogleMapTask
//
//  Created by jets on 12/5/1440 AH.
//  Copyright © 1440 AH Anas. All rights reserved.
//

import UIKit
import Firebase
class SavedLocationsTableViewController: UITableViewController {
    var ref: DatabaseReference!
    var myLocationList = [LocationModel]()
    let cellReuseIdentifier = "LocationCell"
    var user = User()
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        LoadLocations()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
  
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myLocationList.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! LocationCellTableViewCell
     cell.labelLoctionCellUserName.text = user.userName
     cell.labelLocationCellPassword.text = user.password
        cell.labelLocationCellToken.text = user.uid
        cell.labelLocationCellLocation.text = myLocationList[indexPath.row].city + " " + myLocationList[indexPath.row].country
        
     // Configure the cell...
     
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
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func LoadLocations() {
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).child("loctions").observe(.childAdded, with: { (snapshot) in
            
            let results = snapshot.value as? [String : AnyObject]
            let city = results?["city"]
            let country = results?["country"]
            let myLocations = LocationModel(city: (city as! String?)!, country: (country as! String?)!)
            self.myLocationList.append(myLocations)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        })
    }
}
