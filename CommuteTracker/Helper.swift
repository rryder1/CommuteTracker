//
//  Helper.swift
//  CommuteTracker
//
//  Created by Robert Ryder on 6/19/17.
//  Copyright © 2017 Robert Ryder. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Helper {
    
    
    static func updateStats(prevDataField: UILabel, prevCommuteField: UILabel){
        
        let user: String = Auth.auth().currentUser!.uid
        
        var commuteArray: [Commutes] = []
        
        var sum = 0.0

        
        Database.database().reference().child("Users").child(user).child("Trips").observe(DataEventType.childAdded, with: { (snapshot) in
            
            let dict = snapshot.value as? NSDictionary
            let commuteBuilder = Commutes()
            
            if dict?["Distance"] != nil {
                commuteBuilder.distance = dict?["Distance"] as? Double
            }
            if dict?["TripName"] != nil {
                commuteBuilder.title = dict?["TripName"] as? String
            }
            if dict?["Transport"] != nil {
                commuteBuilder.transportType = dict?["Transport"] as? String
            }
            
            sum = sum + commuteBuilder.distance!
            print(sum)
            
            commuteArray.append(commuteBuilder)
            prevDataField.text? = String(sum)
            prevCommuteField.text? = String(commuteArray.count)
            
            
        })
        
        print("complete")
        
    }
    
    static func updateTableView(tableView:UITableView){
        tableView.reloadData();
    }
    
    
}
