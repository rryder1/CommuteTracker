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
    
    var trip : Commute = Commute((context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext))
    
    // Outlets
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var bikeWalkToggle: UISegmentedControl!
    
    @IBOutlet weak var tripNameText: UITextField!
    
    @IBOutlet weak var distanceText: UITextField!
    
    let user: String = Auth.auth().currentUser!.uid

    
    // Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        distanceText.keyboardType = .numberPad
        
        // Do any additional setup after loading the view.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        let ref = Database.database().reference().child("Users").child(user).child("Trips").childByAutoId()
        
        if Double(distanceText.text!) != nil {
            trip.distance = Double(distanceText.text!)!
            ref.child("Distance").setValue(trip.distance)
        } else {
            print("invaliddouble")
        }
        if tripNameText != nil {
            trip.title = tripNameText.text!
            ref.child("Trip Name").setValue(trip.title)
        }
        
        let tripType = bikeWalkToggle.titleForSegment(at: bikeWalkToggle.selectedSegmentIndex)
        
        trip.transportType = tripType
        ref.child("Transport").setValue(trip.transportType)
        
        if trip.title != nil {
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController!.popViewController(animated: true)
        }
        
    }
    
    
}
