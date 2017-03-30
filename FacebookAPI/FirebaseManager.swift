//
//  FirebaseManager.swift
//  FacebookAPI
//
//  Created by Hyung Jip Moon on 2017-03-28.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirebaseManager: NSObject {

    var ref: FIRDatabaseReference!

    // Function that writes events id to Firebase DB.
    class func writeToFirebaseDBAttendingEvents(indexPath: IndexPath, eventsArray : Array<Any>?) {
        
        let newFirebaseManager = FirebaseManager()


        newFirebaseManager.ref = FIRDatabase.database().reference()

        
        guard let eventsArray = eventsArray, let firebaseUserID = UserDefaults.standard.object(forKey: "uid") as? String else {
            print("There is an issue")
            return
        }
        
        let listOfEventsID = (eventsArray[indexPath.row] as! Event).eventID
        
        guard let eventCity = (eventsArray[indexPath.row] as! Event).cityName else {
                return
        }
        guard let eventCountry = (eventsArray[indexPath.row] as! Event).countryName else {
            return
        }
        guard let eventDescription = (eventsArray[indexPath.row] as! Event).eventDescription else {
            return
        }

        guard let eventName = (eventsArray[indexPath.row] as! Event).eventName else {
            return
        }

        guard let eventLatitude = (eventsArray[indexPath.row] as! Event).latitute else {
            return
        }

        guard let eventLongtitude = (eventsArray[indexPath.row] as! Event).longitude else {
            return
        }

        guard let eventPlaceID = (eventsArray[indexPath.row] as! Event).placeID else {
            return
        }

        guard let eventPlaceName = (eventsArray[indexPath.row] as! Event).placeName else {
            return
        }

        guard let eventRSVPStatus = (eventsArray[indexPath.row] as! Event).rsvpStatus else {
            return
        }

        guard let eventStartTime = (eventsArray[indexPath.row] as! Event).startTime else {
            return
        }

        guard let eventState = (eventsArray[indexPath.row] as! Event).state else {
            return
        }

        guard let eventZipcode = (eventsArray[indexPath.row] as! Event).zipCode else {
            return
        }

        
        // Writing the list of events to firebase database
        let writeToFirebaseDB = newFirebaseManager.ref.child("user_profile").child("\(firebaseUserID)").child("hosting_events_array")
        
        writeToFirebaseDB.child("\(listOfEventsID!)/event_id").setValue(listOfEventsID!)
        
        writeToFirebaseDB.child("\(listOfEventsID!)/event_city").setValue(eventCity)
        
        writeToFirebaseDB.child("\(listOfEventsID!)/event_country").setValue(eventCountry)
        writeToFirebaseDB.child("\(listOfEventsID!)/event_description").setValue(eventDescription)
        writeToFirebaseDB.child("\(listOfEventsID!)/event_name").setValue(eventName)
        writeToFirebaseDB.child("\(listOfEventsID!)/event_latitude").setValue(eventLatitude)
        writeToFirebaseDB.child("\(listOfEventsID!)/event_longtitude").setValue(eventLongtitude)
        writeToFirebaseDB.child("\(listOfEventsID!)/event_placeID").setValue(eventPlaceID)
        writeToFirebaseDB.child("\(listOfEventsID!)/event_placename").setValue(eventPlaceName)
        writeToFirebaseDB.child("\(listOfEventsID!)/event_RSVP_status").setValue(eventRSVPStatus)
        writeToFirebaseDB.child("\(listOfEventsID!)/event_start_time").setValue(eventStartTime)
        writeToFirebaseDB.child("\(listOfEventsID!)/event_state").setValue(eventState)
        writeToFirebaseDB.child("\(listOfEventsID!)/event_zipcode").setValue(eventZipcode)
    }
    
    class func writeToFirebaseDBUserName(userName : String) {
        
        let newFirebaseManager = FirebaseManager()
        
        newFirebaseManager.ref = FIRDatabase.database().reference()
        
        guard let firebaseUserID = UserDefaults.standard.object(forKey: "uid") as? String else {
            print("There is an issue")
            return
        }
        
        // Writing the list of events to firebase database
        let writeToFirebaseDB = newFirebaseManager.ref.child("user_profile").child("\(firebaseUserID)").child("user_name")
        


        
        writeToFirebaseDB.setValue(userName)


        
        
    }
    
}
