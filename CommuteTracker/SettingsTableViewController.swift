//
//  SettingsTableViewController.swift
//  CommuteTracker
//
//  Created by Robert Ryder on 6/25/17.
//  Copyright © 2017 Robert Ryder. All rights reserved.
//

import UIKit
import Firebase

class SettingsTableViewController: UITableViewController {
    
    var selectedRow: Int? = nil
    let user: String = Auth.auth().currentUser!.uid
    var commonArray: [Commutes] = []

    @IBOutlet weak var commonCommute0: UILabel!
    @IBOutlet weak var commonCommute1: UILabel!
    @IBOutlet weak var commonCommute2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        Database.database().reference().child("Users").child(user).child("CommonCommutes").observe(DataEventType.childAdded, with: { (snapshot) in
            
            let dict = snapshot.value as? NSDictionary
            let commuteBuilder = Commutes()
            
            commuteBuilder.key = snapshot.key
            
            if dict?["Distance"] != nil {
                commuteBuilder.distance = dict?["Distance"] as? Double
            }
            if dict?["TripName"] != nil {
                commuteBuilder.title = dict?["TripName"] as? String
            }
            if dict?["Transport"] != nil {
                commuteBuilder.transportType = dict?["Transport"] as? String
            }
            
            self.commonArray.append(commuteBuilder)
            if snapshot.key == "0" {
                self.commonCommute0.text = commuteBuilder.title
            }
            if snapshot.key == "1" {
                self.commonCommute1.text = commuteBuilder.title
            }
            if snapshot.key == "2" {
                self.commonCommute2.text = commuteBuilder.title
            }
            
            
            
        })

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1){
            self.selectedRow = indexPath.row
            self.performSegue(withIdentifier: "commonCommuteSegue", sender: nil)
        }
        
        
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    } */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "commonCommuteSegue"){
            let nextVC = (segue.destination as! AddTripViewController)
            nextVC.source = "Settings"
            nextVC.row = selectedRow!;
        }
    }
 

}
