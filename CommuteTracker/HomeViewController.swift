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
    
    var commuteArray : [Commute] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getCommutes()
        totalMiles.text = String(sumCommutes())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCommutes() {
        
        let contextname = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            commuteArray = try contextname.fetch(Commute.fetchRequest()) as! [Commute]
        } catch {
            print("ERROR")
        }
        
    }
    
    func sumCommutes() -> Double {
        var sum = 0.0
        for i in 0 ..< commuteArray.count{
            sum = sum + commuteArray[i].distance
        }
        
        return sum
    }


}

