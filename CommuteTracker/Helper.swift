//
//  Helper.swift
//  CommuteTracker
//
//  Created by Robert Ryder on 6/19/17.
//  Copyright © 2017 Robert Ryder. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    static func getCommutes() -> [Commute]{
        
        var commuteArray: [Commute]! = nil
        
        let contextname = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            commuteArray = try contextname.fetch(Commute.fetchRequest()) as! [Commute]
        } catch {
            print("ERROR")
        }
        
        return commuteArray
        
    }
    
    
    
}
