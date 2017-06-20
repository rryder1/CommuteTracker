//
//  AddTripViewController.swift
//  CommuteTracker
//
//  Created by Robert Ryder on 6/18/17.
//  Copyright © 2017 Robert Ryder. All rights reserved.
//

import UIKit
import SideMenu

class AddTripViewController: UIViewController {
    
    var trip : Commute = Commute((context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext))
    
    // Outlets
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var bikeWalkToggle: UISegmentedControl!
    
    @IBOutlet weak var tripNameText: UITextField!
    
    @IBOutlet weak var distanceText: UITextField!
    
    // Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        if Double(distanceText.text!) != nil {
            trip.distance = Double(distanceText.text!)!
        } else {
            print("invaliddouble")
        }
        if tripNameText != nil {
            trip.title = tripNameText.text!
        }
        
        let tripType = bikeWalkToggle.titleForSegment(at: bikeWalkToggle.selectedSegmentIndex)
        
        trip.transportType = tripType
        
        if trip.title != nil {
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController!.popViewController(animated: true)
        }
        
    }
    
    
}
