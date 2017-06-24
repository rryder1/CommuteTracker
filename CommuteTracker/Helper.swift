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
    
    
    static func getCommutes() -> (Double) {
        
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
            
            sum += commuteBuilder.distance!
            print(sum)
            
            commuteArray.append(commuteBuilder)
            
            
            
        })
        print("complete")
        
        return sum
    }
    
    
    
}
