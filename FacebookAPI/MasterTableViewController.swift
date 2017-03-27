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
    
    @IBOutlet weak var eventSegmentedDisplay: UISegmentedControl!
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
        
//        DataManager.getEventDetails { (Event) in
//            
//            //code
//        }
        
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
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            //pass on the userID to the next screen
            let indexPath:IndexPath = tableView.indexPathForSelectedRow!
            let detailVC:DetailViewController = segue.destination as! DetailViewController
            
            //need to call the thing here. The event that we pass in is equal to this indexpath.row's event
            let eventThatWasSelected = self.eventsArray?[indexPath.row].eventID
//            print(eventThatWasSelected)
            
            
//            DataManager.getEventImage { event in
//             
////                detailVC.detailEvent?.coverPhoto = event.coverPhoto
//            }
            
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
