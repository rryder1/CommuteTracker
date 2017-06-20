//
//  HomeViewController.swift
//  CommuteTracker
//
//  Created by Robert Ryder on 6/17/17.
//  Copyright © 2017 Robert Ryder. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {

    @IBOutlet weak var consecutiveCommutes: UILabel!
    @IBOutlet weak var totalMiles: UILabel!
    
    var commuteArray : [Commute] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        commuteArray = Helper.getCommutes()
        totalMiles.text = String(sumCommutes())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func sumCommutes() -> Double {
        var sum = 0.0
        for i in 0 ..< commuteArray.count{
            sum = sum + commuteArray[i].distance
        }
        
        return sum
    }


}

