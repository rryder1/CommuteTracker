//
//  HomeViewController.swift
//  CommuteTracker
//
//  Created by Robert Ryder on 6/17/17.
//  Copyright © 2017 Robert Ryder. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var consecutiveCommutes: UILabel!
    @IBOutlet weak var totalMiles: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

