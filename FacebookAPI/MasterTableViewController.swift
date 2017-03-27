//
//  MasterTableViewController.swift
//  FacebookAPI
//
//  Created by Scott Hetland on 2017-03-23.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import FacebookCore

class MasterTableViewController: UITableViewController {
    
    var eventsArray:[Event]?
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
        
        //do I need to event pass anything in then?
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataManager.getEvents
            { events in
                if events.count > 0
                {
                    self.eventsArray = events
                    print("table view: \(self.eventsArray!)")
                    self.tableView.reloadData()
                }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.events.count
        return self.eventsArray?.count ?? 0
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)


        //just use the basic cell to display the title of the event
        cell.textLabel?.text = self.eventsArray?[indexPath.row].eventName

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //this is for the attendee page
        if (segue.identifier == "detailSegue") {
            //pass on the userID to the next screen
            let indexPath:IndexPath = tableView.indexPathForSelectedRow!
            let detailVC:DetailViewController = segue.destination as! DetailViewController
            
            detailVC.detailEvent = self.eventsArray?[indexPath.row]
        }
        
        //perform this segue to the host view
        if (segue.identifier == "showHostView") {
            let indexPath:IndexPath = tableView.indexPathForSelectedRow!
            let detailVC:DetailViewController = segue.destination as! DetailViewController
            
            detailVC.detailEvent = self.eventsArray?[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //need to do the requests here when the cell is selected. Refactor to move network requests to the target view controller
        
        let eventThatWasSelected = self.eventsArray?[indexPath.row].eventID
        
        DataManager.getEventImage(eventID: eventThatWasSelected!) { image in
            
            self.eventsArray?[indexPath.row].coverPhoto = image.photo
        }
        
        DataManager.getEventAttendees(eventID: eventThatWasSelected!) { attendees in
            
            self.eventsArray?[indexPath.row].attendees = attendees
        }
        
        DataManager.getEventAdmins(eventID: eventThatWasSelected!) { admins in
            
            self.eventsArray?[indexPath.row].admins = admins
            
        }
        
        //if userID is equal to a adminID, perform host segue, else perform other segue
        
        //check to see if user ID is is equal to one of the admin IDs. Need to do a for loop to check for it.
        
        performSegue(withIdentifier: "detailSegue", sender: self)
    }

}
