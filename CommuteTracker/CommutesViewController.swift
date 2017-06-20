//
//  CommutesViewController.swift
//  CommuteTracker
//
//  Created by Robert Ryder on 6/18/17.
//  Copyright © 2017 Robert Ryder. All rights reserved.
//

import UIKit

class CommutesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var commuteTableView: UITableView!
    
    var commutes : [Commute]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commutes = Helper.getCommutes()
        commuteTableView.delegate = self
        commuteTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        commutes = Helper.getCommutes()
        commuteTableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (commutes?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(commutes![indexPath.row].title!) by \(commutes![indexPath.row].transportType!) \n Distance: \(commutes![indexPath.row].distance) miles"
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
