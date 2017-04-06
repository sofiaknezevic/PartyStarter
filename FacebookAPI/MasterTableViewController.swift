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
    var userID = String()
    var user = User()
    //var firebaseUserID : String?
    var ref: FIRDatabaseReference!

    //these two arrays are going to populate the firebase. Maybe make a boolean for hosting on Event class
    var hostingArray = [Event]()
    var attendingArray = [Event]()
    @IBOutlet weak var refreshButtonOutlet: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        //this is a problem, we can't put this in the viewdidload!!!!
        //print name
        DataManager.getUserInfo
        { user in
            
            FirebaseManager.writeToFirebaseDBUserName(userName: user.name!)
            print(user.name!)
            
            self.user = user
            
            self.userID = user.userID!
            print(self.userID)
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
        
        setUp()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.eventsArray = nil
        
        if (self.hostingArray.count == 0 && self.attendingArray.count == 0) {

            refreshTableView()

        }
    }

    @IBAction func refreshTableViewButton(_ sender: UIBarButtonItem) {
        
        refreshTableView()
    }

    
    func refreshTableView() {
        
        refreshButtonOutlet.isEnabled = false
        
        self.hostingArray = []
        self.attendingArray = []
        
        DataManager.getEvents
            { events in
                if events.count > 0
                {
                    
                    //for loop to go through the events in the array and get an array of admins for each event
                    for event in events {
                        //get the admins for that event
                        DataManager.getEventAdmins(eventID: event.eventID!) { admins in
                            
                            //add this array of admins to the event object
                            event.admins = (admins)
                            
                            if admins.contains(where: { $0.adminID == self.userID }) {
                                self.hostingArray.append(event)
                                print("hosting this event: \(event.eventID)")
                                
                                
                            } else {
                                self.attendingArray.append(event)
                                print("attending this event: \(event.eventID)")
                                
                            }
                            
                            DataManager.getEventAttendees(eventID: event.eventID!) { attendees in
                                event.attendees = (attendees)
                                self.refreshButtonOutlet.isEnabled = true

                            }
                            
                            self.tableView.reloadData()
                            print("reloaded")
                            
                        }

                    }

                    
                }
        }
    }
    
    // MARK: - Initial Setup -
    
    func setUp() -> Void
    {
        
        let frame = CGRect(x: 0, y: 0, width: 400, height: 44)
        let navLabel = UILabel(frame: frame)
        navLabel.font = UIFont(name: "Congratulations DEMO", size: 30.00)
        navLabel.textAlignment = .center
        navLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navLabel.text = "PartyStarter"
        self.navigationItem.titleView = navLabel
        
    }

    // MARK: - Table view data source -

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if (section == 0) {
            return "Hosting"
        } else {
            return "Attending"
        }
    }
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return self.hostingArray.count
        } else {
            return self.attendingArray.count
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if (indexPath.section == 0) {
 
            cell.textLabel?.text = self.hostingArray[indexPath.row].eventName
            
        } else {
            
            cell.textLabel?.text = self.attendingArray[indexPath.row].eventName

        }
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.section == 0) {
            self.performSegue(withIdentifier: "showHostGoals", sender: nil)
        } else {
            self.performSegue(withIdentifier: "showAttendingGoals", sender: nil)
        }
        
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            return
        }
        
        //this is for the attendee page
        if (segue.identifier == "showAttendingGoals") {
            //pass on the userID to the next screen?
            
            let attendingGoalsVC:AttendingGoalsViewController = segue.destination as! AttendingGoalsViewController
            attendingGoalsVC.attendingEvent = self.attendingArray[indexPath.row]
            
            print("attending goals")
        }
        
        //perform this segue to the host view
        if (segue.identifier == "showHostGoals") {
            
            let hostGoalsVC:HostGoalsViewController = segue.destination as! HostGoalsViewController
            hostGoalsVC.hostEvent = self.hostingArray[indexPath.row]
            hostGoalsVC.hostUser = self.user
            
            print("host goals")
            
        }
        
    }
    
}
