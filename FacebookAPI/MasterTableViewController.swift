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
    var firebaseUserID : String?
    var ref: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
       

        //print name
        DataManager.getUserInfo
        { user in
            print(user.name!)
                
            self.userID = user.userID
            print(self.userID!)
        }
        
        
        ref = FIRDatabase.database().reference()

        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                // User is signed in.
                print("start login success: " + (user?.email)! )
                
                self.firebaseUserID = user?.uid
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

        writeToFirebaseDB(indexPath: indexPath)
        
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

    // Function that writes events id to Firebase DB.
    func writeToFirebaseDB(indexPath: IndexPath) {
        
        if let data = UserDefaults.standard.object(forKey: "uid") as? String {
            firebaseUserID = data
        }
            
        else {
            print("There is an issue")
        }
        
        let listOfEventsID = self.eventsArray?[indexPath.row].eventID
        
        let eventCity = self.eventsArray?[indexPath.row].cityName
        let eventCountry = self.eventsArray?[indexPath.row].countryName
        let eventDescription = self.eventsArray?[indexPath.row].eventDescription
        let eventName = self.eventsArray?[indexPath.row].eventName
        let eventLatitude = self.eventsArray?[indexPath.row].latitute
        let eventLongtitude = self.eventsArray?[indexPath.row].longitude
        let eventPlaceID = self.eventsArray?[indexPath.row].placeID
        let eventPlaceName = self.eventsArray?[indexPath.row].placeName
        let eventRSVPStatus = self.eventsArray?[indexPath.row].rsvpStatus
        let eventStartTime = self.eventsArray?[indexPath.row].startTime
        let eventState = self.eventsArray?[indexPath.row].state
        let eventZipcode = self.eventsArray?[indexPath.row].zipCode

        // Writing the list of events to firebase database
        self.ref.child("user_profile").child("\(firebaseUserID!)").child("\(listOfEventsID!)/event_id").setValue(listOfEventsID!)
        self.ref.child("user_profile").child("\(firebaseUserID!)").child("\(listOfEventsID!)/event_city").setValue(eventCity!)
        self.ref.child("user_profile").child("\(firebaseUserID!)").child("\(listOfEventsID!)/event_country").setValue(eventCountry!)
        self.ref.child("user_profile").child("\(firebaseUserID!)").child("\(listOfEventsID!)/event_description").setValue(eventDescription!)
        self.ref.child("user_profile").child("\(firebaseUserID!)").child("\(listOfEventsID!)/event_name").setValue(eventName!)
        self.ref.child("user_profile").child("\(firebaseUserID!)").child("\(listOfEventsID!)/event_latitude").setValue(eventLatitude!)
        self.ref.child("user_profile").child("\(firebaseUserID!)").child("\(listOfEventsID!)/event_longtitude").setValue(eventLongtitude!)
        self.ref.child("user_profile").child("\(firebaseUserID!)").child("\(listOfEventsID!)/event_placeID").setValue(eventPlaceID!)
        self.ref.child("user_profile").child("\(firebaseUserID!)").child("\(listOfEventsID!)/event_placename").setValue(eventPlaceName!)
        
        self.ref.child("user_profile").child("\(firebaseUserID!)").child("\(listOfEventsID!)/event_RSVP_status").setValue(eventRSVPStatus!)
        self.ref.child("user_profile").child("\(firebaseUserID!)").child("\(listOfEventsID!)/event_start_time").setValue(eventStartTime!)
        self.ref.child("user_profile").child("\(firebaseUserID!)").child("\(listOfEventsID!)/event_state").setValue(eventState!)
        self.ref.child("user_profile").child("\(firebaseUserID!)").child("\(listOfEventsID!)/event_zipcode").setValue(eventZipcode!)
    }
}
