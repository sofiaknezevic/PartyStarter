//
//  DetailViewController.swift
//  FacebookAPI
//
//  Created by Scott Hetland on 2017-03-22.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import FacebookCore

//probably change this to a table view for the next view
class DetailViewController: UIViewController {
    

    var userID:String?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //print name
        DataManager.getUserInfo
        { user in
            print(user.name!)
            
            self.userID = user.userID
            print(self.userID!)
        }
        
        //print out the events
        DataManager.getEvents { event in }
    
}
}
