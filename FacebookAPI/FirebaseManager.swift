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
    class func writeToFirebaseDBHostingEvents(indexPath: IndexPath, eventsArray : Array<Any>?) {
        
        let newFirebaseManager = FirebaseManager()
        
        newFirebaseManager.ref = FIRDatabase.database().reference()

        guard let eventsArray = eventsArray, let firebaseUserID = UserDefaults.standard.object(forKey: "uid") as? String else {
            print("There is an issue")
            return
        }
        
        let getEventsFromArray = (eventsArray[indexPath.row] as? Event)
        
        let listOfEventsID = getEventsFromArray?.eventID
        let eventCity = getEventsFromArray?.cityName ?? ""
        let eventCountry = getEventsFromArray?.countryName ?? ""
        let eventDescription = getEventsFromArray?.eventDescription ?? ""
        let eventName = getEventsFromArray?.eventName ?? ""
        let eventLatitude = getEventsFromArray?.latitute ?? nil
        let eventLongtitude = getEventsFromArray?.longitude ?? nil
        let eventPlaceID = getEventsFromArray?.placeID ?? ""
        let eventPlaceName = getEventsFromArray?.placeName ?? ""
        let eventRSVPStatus = getEventsFromArray?.rsvpStatus ?? ""
        let eventStartTime = getEventsFromArray?.startTime ?? ""
        let eventState = getEventsFromArray?.state ?? ""
        let eventZipcode = getEventsFromArray?.zipCode ?? ""
        
        // Writing the list of events to firebase database
        let writeHostingArrayToFirebaseDB = newFirebaseManager.ref.child("user_profile").child("\(firebaseUserID)").child("hosting_events_array")
        
        writeHostingArrayToFirebaseDB.child("\(listOfEventsID!)/event_id").setValue(listOfEventsID!)
        
        writeHostingArrayToFirebaseDB.child("\(listOfEventsID!)/event_city").setValue(eventCity)
        writeHostingArrayToFirebaseDB.child("\(listOfEventsID!)/event_country").setValue(eventCountry)
        writeHostingArrayToFirebaseDB.child("\(listOfEventsID!)/event_description").setValue(eventDescription)
        writeHostingArrayToFirebaseDB.child("\(listOfEventsID!)/event_name").setValue(eventName)
        writeHostingArrayToFirebaseDB.child("\(listOfEventsID!)/event_latitude").setValue(eventLatitude)
        writeHostingArrayToFirebaseDB.child("\(listOfEventsID!)/event_longtitude").setValue(eventLongtitude)
        writeHostingArrayToFirebaseDB.child("\(listOfEventsID!)/event_placeID").setValue(eventPlaceID)
        writeHostingArrayToFirebaseDB.child("\(listOfEventsID!)/event_placename").setValue(eventPlaceName)
        writeHostingArrayToFirebaseDB.child("\(listOfEventsID!)/event_RSVP_status").setValue(eventRSVPStatus)
        writeHostingArrayToFirebaseDB.child("\(listOfEventsID!)/event_start_time").setValue(eventStartTime)
        writeHostingArrayToFirebaseDB.child("\(listOfEventsID!)/event_state").setValue(eventState)
        writeHostingArrayToFirebaseDB.child("\(listOfEventsID!)/event_zipcode").setValue(eventZipcode)
    
    }
    
    // Function that writes events id to Firebase DB.
    class func writeToFirebaseDBAttendingEvents(indexPath: IndexPath, eventsArray : Array<Any>?) {
        
        let newFirebaseManager = FirebaseManager()
        
        newFirebaseManager.ref = FIRDatabase.database().reference()
        
        guard let eventsArray = eventsArray, let firebaseUserID = UserDefaults.standard.object(forKey: "uid") as? String else {
            print("There is an issue")
            return
        }
        
        let getEventsFromArray = (eventsArray[indexPath.row] as? Event)
        
        let listOfEventsID = getEventsFromArray?.eventID
        let eventCity = getEventsFromArray?.cityName ?? ""
        let eventCountry = getEventsFromArray?.countryName ?? ""
        let eventDescription = getEventsFromArray?.eventDescription ?? ""
        let eventName = getEventsFromArray?.eventName ?? ""
        let eventLatitude = getEventsFromArray?.latitute ?? nil
        let eventLongtitude = getEventsFromArray?.longitude ?? nil
        let eventPlaceID = getEventsFromArray?.placeID ?? ""
        let eventPlaceName = getEventsFromArray?.placeName ?? ""
        let eventRSVPStatus = getEventsFromArray?.rsvpStatus ?? ""
        let eventStartTime = getEventsFromArray?.startTime ?? ""
        let eventState = getEventsFromArray?.state ?? ""
        let eventZipcode = getEventsFromArray?.zipCode ?? ""
        
        
        let writeAttendingArrayToFirebaseDB = newFirebaseManager.ref.child("user_profile").child("\(firebaseUserID)").child("attending_events_array")
        
        writeAttendingArrayToFirebaseDB.child("\(listOfEventsID!)/event_city").setValue(eventCity)
        writeAttendingArrayToFirebaseDB.child("\(listOfEventsID!)/event_country").setValue(eventCountry)
        writeAttendingArrayToFirebaseDB.child("\(listOfEventsID!)/event_description").setValue(eventDescription)
        writeAttendingArrayToFirebaseDB.child("\(listOfEventsID!)/event_name").setValue(eventName)
        writeAttendingArrayToFirebaseDB.child("\(listOfEventsID!)/event_latitude").setValue(eventLatitude)
        writeAttendingArrayToFirebaseDB.child("\(listOfEventsID!)/event_longtitude").setValue(eventLongtitude)
        writeAttendingArrayToFirebaseDB.child("\(listOfEventsID!)/event_placeID").setValue(eventPlaceID)
        writeAttendingArrayToFirebaseDB.child("\(listOfEventsID!)/event_placename").setValue(eventPlaceName)
        writeAttendingArrayToFirebaseDB.child("\(listOfEventsID!)/event_RSVP_status").setValue(eventRSVPStatus)
        writeAttendingArrayToFirebaseDB.child("\(listOfEventsID!)/event_start_time").setValue(eventStartTime)
        writeAttendingArrayToFirebaseDB.child("\(listOfEventsID!)/event_state").setValue(eventState)
        writeAttendingArrayToFirebaseDB.child("\(listOfEventsID!)/event_zipcode").setValue(eventZipcode)
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
    
    class func writeToFirebaseDBPartyItem(partyItemName : String, eventID : String, partyItemsArray : Array<Any>?) {
    
        let newFirebaseManager = FirebaseManager()
        
        newFirebaseManager.ref = FIRDatabase.database().reference()
        
        
       guard let partyItemsArray = partyItemsArray, let firebaseUserID = UserDefaults.standard.object(forKey: "uid") as? String else {
            print("There is an issue")
            return
        }
        
        for i in 0..<partyItemsArray.count {
            
            let getEventsFromArray = (partyItemsArray[i] as? PartyItem)
            let listOfPartyItems = getEventsFromArray?.itemName


        // Writing the list of events to firebase database
        newFirebaseManager.ref.child("party_item").child("\(firebaseUserID)").child("\(eventID)").child("\(listOfPartyItems!)").setValue(listOfPartyItems)
        }
    }
    
    class func writeToFirebaseDBEvents(partyItemName : String, eventID : String, partyItemsArray : Array<Any>?) {
        
        let newFirebaseManager = FirebaseManager()
        
        newFirebaseManager.ref = FIRDatabase.database().reference()
        
        

        guard let partyItemsArray = partyItemsArray, let firebaseUserID = UserDefaults.standard.object(forKey: "uid") as? String, let stripeUserID = UserDefaults.standard.object(forKey: "stripe_id") as? String else {
            print("There is an issue")
            return
        }
        
        for i in 0..<partyItemsArray.count {
            
            let getEventsFromArray = (partyItemsArray[i] as? PartyItem)
            let listOfPartyItems = getEventsFromArray?.itemName
            
            
            // Writing the list of events to firebase database
            newFirebaseManager.ref.child("events").child("\(firebaseUserID)").child("\(eventID)").child("stripe_user_id").setValue("\(stripeUserID)")
            newFirebaseManager.ref.child("events").child("\(firebaseUserID)").child("\(eventID)").child("\(listOfPartyItems!)").setValue(listOfPartyItems)
        }
        

    }
    func getFirebaseUserID(firebaseUserID : String) {
        
        
    }
}
