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
        
        
        //need to check if the user is a host of the event, then move them to the target view controller
        
        if (segue.identifier == "detailSegue") {
            //pass on the userID to the next screen
            let indexPath:IndexPath = tableView.indexPathForSelectedRow!
            let detailVC:DetailViewController = segue.destination as! DetailViewController
            
            //need to call the thing here. The event that we pass in is equal to this indexpath.row's event
            let eventThatWasSelected = self.eventsArray?[indexPath.row].eventID            
            
            DataManager.getEventImage(eventID: eventThatWasSelected!) { image in
             
                    self.eventsArray?[indexPath.row].coverPhoto = image.photo
            }
            
            DataManager.getEventAdmins(eventID: eventThatWasSelected!) { admins in
                //need to set the admins for the event to the admins that you got
                self.eventsArray?[indexPath.row].admins = admins
                
            }
            
            DataManager.getEventAttendees(eventID: eventThatWasSelected!) { attendees in
                //what do I do in this block here?
                self.eventsArray?[indexPath.row].attendees = attendees
            }
            
            detailVC.detailEvent = self.eventsArray?[indexPath.row]

        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }

}
