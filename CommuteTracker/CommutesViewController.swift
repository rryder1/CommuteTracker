//
//  CommutesViewController.swift
//  CommuteTracker
//
//  Created by Robert Ryder on 6/18/17.
//  Copyright © 2017 Robert Ryder. All rights reserved.
//

import UIKit
import Firebase

class CommutesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let user: String = Auth.auth().currentUser!.uid
    
    var commuteArray: [Commutes] = []
    
    var deleteID = ""
    
    
    
    @IBOutlet weak var commuteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commuteTableView.delegate = self
        commuteTableView.dataSource = self
        
        // Function to retrieve Data from Firebase
        
        Database.database().reference().child("Users").child(user).child("Trips").observe(DataEventType.childAdded, with: { (snapshot) in
            
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
            
            self.commuteArray.append(commuteBuilder)
            
            self.commuteTableView.reloadData()
            
            
        })
        
        Database.database().reference().child("Users").child(user).child("Trips").observe(DataEventType.childRemoved, with: { (snapshot) in
            
            var index = 0
            for trips in self.commuteArray{
                if trips.key == self.deleteID{
                    self.commuteArray.remove(at: index)
                }
                index += 1
            }
            
            self.commuteTableView.reloadData()
            
        })
        
        Database.database().reference().child("Users").child(user).child("Trips").observe(DataEventType.childChanged, with: { (snapshot) in
            
            self.commuteTableView.reloadData()
            
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.commuteTableView.reloadData()
        
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete") { action, index in
            
            self.deleteID = self.commuteArray[indexPath.row].key
            Database.database().reference().child("Users").child(self.user).child("Trips").child(self.deleteID).removeValue()
            
        }
        
        return [delete]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (commuteArray.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.numberOfLines = 0
        
        if commuteArray[indexPath.row].isFilled(){
        cell.textLabel?.text = "\(commuteArray[indexPath.row].title!) by \(commuteArray[indexPath.row].transportType!) \n Distance: \(String(describing: commuteArray[indexPath.row].distance!)) miles"}
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
