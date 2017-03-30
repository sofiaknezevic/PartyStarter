//
//  MasterTableViewController.swift
//  FacebookAPI
//
//  Created by Scott Hetland on 2017-03-23.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import FacebookCore
import FirebaseAuth
import FirebaseDatabase

class MasterTableViewController: UITableViewController {
    

    var eventsArray:[Event]?
    var userID:String?
    var user:User?
    //var firebaseUserID : String?
    var ref: FIRDatabaseReference!

    //these two arrays are going to populate the firebase. Maybe make a boolean for hosting on Event class
    var hostingArray:[Event]?
    var attendingArray:[Event]?

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //print name
        DataManager.getUserInfo
        { user in
            
            FirebaseManager.writeToFirebaseDBUserName(userName: user.name!)
            print(user.name!)
            
            self.user = user
            
            self.userID = user.userID
            print(self.userID!)
        }
        
        
        ref = FIRDatabase.database().reference()

        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                // User is signed in.
                print("start login success: " + (user?.email)! )
                
                //self.firebaseUserID = user?.uid
                //self.performSegue(withIdentifier: loginToList, sender: nil)
            } else {
                // No user is signed in.
                print("No user is signed in.")
            }
        }
        
        
        //do I need to event pass anything in then?
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.eventsArray = nil
        var adminArray = [[Admins]]()

        
        
        DataManager.getEvents
            { events in
                if events.count > 0
                {
                    self.eventsArray = events
                    print("table view: \(self.eventsArray!)")
                    
                    //for loop to go through the events in the array and get an array of admins for each event
                    for event in events {
                        //get the admins for that event
                        DataManager.getEventAdmins(eventID: event.eventID!) { admins in
                            //will add an array of admins to an array of event admins
                            adminArray.append(admins)
//                            print("this are admins*: \(admins)")
                            print("this is the array: \(adminArray)")

                        }

                    }
                    
                    
//                    self.tableView.reloadData()
                    //check which events you are an admin in. If you are hosting then put it in the hostingArray else put it in the attending array
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

        FirebaseManager.writeToFirebaseDBAttendingEvents(indexPath: indexPath, eventsArray: self.eventsArray)
        
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            return
        }
        
        //this is for the attendee page
        if (segue.identifier == "showAttendingGoals") {
            //pass on the userID to the next screen
            
            let attendingGoalsVC:AttendingGoalsViewController = segue.destination as! AttendingGoalsViewController
            attendingGoalsVC.attendingEvent = self.eventsArray?[indexPath.row]
            
            print("attending goals")
        }
        
        //perform this segue to the host view
        if (segue.identifier == "showHostGoals") {
            
            let hostGoalsVC:HostGoalsViewController = segue.destination as! HostGoalsViewController
            hostGoalsVC.hostEvent = self.eventsArray?[indexPath.row]
            hostGoalsVC.hostUser = self.user
            
            
            print("host goals")
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //need to do the requests here when the cell is selected. Refactor to move network requests to the target view controller
        

        guard let eventThatWasSelected = self.eventsArray?[indexPath.row].eventID else {
            return
        }

        DataManager.getEventAttendees(eventID: eventThatWasSelected) { attendees in
                                                                      
            self.eventsArray?[indexPath.row].attendees = attendees
        
        
        DataManager.getEventAdmins(eventID: eventThatWasSelected) { admins in
            
            self.eventsArray?[indexPath.row].admins = admins
            
            var isAdmin:Bool = false
            
            //check to see if the user is an admin
            for admin in admins {
                
                if (admin.adminID == self.userID) {
                    isAdmin = true
                }
            }
            
            if (isAdmin == true) {
                self.performSegue(withIdentifier: "showHostGoals", sender: nil)
            } else {
                self.performSegue(withIdentifier: "showAttendingGoals", sender: nil)

            }
            
            
        }
        }
        
    }
}
