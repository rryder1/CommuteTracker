//
//  CommonCommutesViewController.swift
//  CommuteTracker
//
//  Created by Robert Ryder on 6/25/17.
//  Copyright © 2017 Robert Ryder. All rights reserved.
//

import UIKit
import Firebase

class CommonCommutesViewController: UIViewController {
    
    @IBOutlet weak var commute0: UIButton!
    @IBOutlet weak var commute1: UIButton!
    @IBOutlet weak var commute2: UIButton!
    
    let user: String = Auth.auth().currentUser!.uid
    var commonArray: [Commutes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            if (commuteBuilder.key == "0") && (commuteBuilder.title != nil) {
                self.commute0.setTitle(commuteBuilder.title, for: .normal)            }
            if (commuteBuilder.key == "1") && (commuteBuilder.title != nil){
                self.commute1.setTitle(commuteBuilder.title, for: .normal)
            }
            if (commuteBuilder.key == "2") && (commuteBuilder.title != nil){
                self.commute2.setTitle(commuteBuilder.title, for: .normal)
            }
            
            // Do any additional setup after loading the view.
        })
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
