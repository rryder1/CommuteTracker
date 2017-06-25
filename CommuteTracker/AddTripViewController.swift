//
//  AddTripViewController.swift
//  CommuteTracker
//
//  Created by Robert Ryder on 6/18/17.
//  Copyright © 2017 Robert Ryder. All rights reserved.
//

import UIKit
import Firebase

class AddTripViewController: UIViewController {
    
    var trip : Commutes = Commutes()
    
    // Outlets
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var bikeWalkToggle: UISegmentedControl!
    
    @IBOutlet weak var tripNameText: UITextField!
    
    @IBOutlet weak var distanceText: UITextField!
    
    let user: String = Auth.auth().currentUser!.uid
    
    var source = ""
    
    var row = 0
    
    
    // Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        distanceText.keyboardType = .numberPad
        
        // Do any additional setup after loading the view.
        print(source)
        print(row)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        var ref = Database.database().reference()
        
        if (source == "Settings"){
            
            ref = Database.database().reference().child("Users").child(user).child("CommonCommutes").child(String(row))
            
        }else {
            
            ref = Database.database().reference().child("Users").child(user).child("Trips").childByAutoId()
            
        }
        
        
        if Double(distanceText.text!) != nil {
            trip.distance = Double(distanceText.text!)!
        } else {
            print("invaliddouble")
        }
        if tripNameText != nil {
            trip.title = tripNameText.text!
        }
        
        let tripType = bikeWalkToggle.titleForSegment(at: bikeWalkToggle.selectedSegmentIndex)
        
        trip.transportType = tripType!
        
        ref.setValue([
            "Distance": trip.distance!,
            "TripName": trip.title!,
            "Transport": trip.transportType!
            ])
        
        navigationController!.popViewController(animated: true)
        
        
        
        
    }
    
    
    
    
}
