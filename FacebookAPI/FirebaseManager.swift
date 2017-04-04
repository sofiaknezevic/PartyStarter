//
//  FirebaseManager.swift
//  FacebookAPI
//
//  Created by Hyung Jip Moon on 2017-03-28.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class FirebaseManager: NSObject {

    var ref: FIRDatabaseReference!

    
    // Function that writes events id to Firebase DB.
    class func writeToFirebaseDBHostingEvents(indexPath: IndexPath, hostingArray : Array<Any>?) {
        
        let newFirebaseManager = FirebaseManager()

        newFirebaseManager.ref = FIRDatabase.database().reference()

        guard let hostingArray = hostingArray, let firebaseUserID = UserDefaults.standard.object(forKey: "uid") as? String else {
            print("There is an issue")
            return
        }
        
        let getEventsFromArray = (hostingArray[indexPath.row] as? Event)
        
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
    class func writeToFirebaseDBAttendingEvents(indexPath: IndexPath, attendingArray : Array<Any>?) {
        
        let newFirebaseManager = FirebaseManager()
        
        newFirebaseManager.ref = FIRDatabase.database().reference()
        
        guard let attendingArray = attendingArray, let firebaseUserID = UserDefaults.standard.object(forKey: "uid") as? String else {
            print("There is an issue")
            return
        }
        
        let getEventsFromArray = (attendingArray[indexPath.row] as? Event)
        
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
            //print("There is an issue")
            return
        }
        
        // Writing the list of events to firebase database
        let writeToFirebaseDB = newFirebaseManager.ref.child("user_profile").child("\(firebaseUserID)").child("user_name")

        writeToFirebaseDB.setValue(userName)
    }
    
    class func writeToFirebaseDBPartyItem(partyItemName : String, eventID : String, partyItemsArray : Array<Any>?) {
    
        let newFirebaseManager = FirebaseManager()
        
        newFirebaseManager.ref = FIRDatabase.database().reference()
        
        
        var data: NSData = NSData()

       guard let partyItemsArray = partyItemsArray, let firebaseUserID = UserDefaults.standard.object(forKey: "uid") as? String else {
            print("There is an issue retrieving Party Item")
            return
        }
        
        for i in 0..<partyItemsArray.count {
            
            let getEventsFromArray = (partyItemsArray[i] as? PartyItem)
            let listOfPartyItems = getEventsFromArray?.itemName
            let listOfGoals = getEventsFromArray?.itemGoal
            let listOfEventID = getEventsFromArray?.eventID
            //let listOfItemImagePaths = getEventsFromArray?.itemImage
            
            let convertToNSNumber: NSNumber = NSNumber(value: listOfGoals!)
            
            let listOfItemImages = getEventsFromArray?.itemImage
            
//            let imageData: NSData = UIImageJPEGRepresentation(listOfItemImages!, 0.4)! as NSData
//            let imageStr = imageData.base64EncodedString(options: .lineLength64Characters)
//            print("PLEASE PRINT::::::", imageStr)
            
            let imageData: NSData = UIImageJPEGRepresentation(listOfItemImages!, 0.4)! as NSData
            let strBase64 = imageData.base64EncodedString(options: .init(rawValue: 0))
            
            /* Writing the list of party item list under event id */
            newFirebaseManager.ref.child("party_item_list").child("\(eventID)").child("party_item_name").child("\(listOfPartyItems!)").setValue(listOfPartyItems)
            
            /* Writing the list of party item goal amount */
            newFirebaseManager.ref.child("party_item_goal").child("\(listOfPartyItems!)").child("\(eventID)").child("\(firebaseUserID)").setValue(convertToNSNumber)
            
            /* Writing the list of party item images */
            newFirebaseManager.ref.child("party_item_image").child("\(eventID)").child("base64_images").child("\(listOfPartyItems!)").setValue(strBase64)

//            newFirebaseManager.ref.child("party_item").child("\(firebaseUserID)").child("\(eventID)").child("party_item_event_id").child("\(listOfEventID!)").setValue(listOfEventID)
            
            //newFirebaseManager.ref.child("party-item").child("\(listOfPartyItems!)").child("\(eventID)").child("\(firebaseUserID)").updateChildValues(["\(firebaseUserID)": convertToNSNumber])

            //newFirebaseManager.ref.child("party_item").child("\(firebaseUserID)").child("\(eventID)").child("party_item_goal").child("\(convertToNSNumber)").setValue(convertToNSNumber)
            //newFirebaseManager.ref.child("party_item").child("\(firebaseUserID)").child("\(eventID)").child("party_item_image_path").child("\(listOfItemImagePaths!)").setValue(listOfItemImagePaths)


        }
    }
    
    class func writeToFirebaseDBEvents(partyItemName : String, eventID : String, partyItemsArray : Array<Any>?) {
        
        let newFirebaseManager = FirebaseManager()
        
        newFirebaseManager.ref = FIRDatabase.database().reference()
        
        

        //should this say stripe_id??
        guard let partyItemsArray = partyItemsArray, let firebaseUserID = UserDefaults.standard.object(forKey: "uid") as? String, let stripeUserID = UserDefaults.standard.object(forKey: "stripe_id") as? String else {
            print("There is an issue")
            return
        }
        
        for i in 0..<partyItemsArray.count {
            
            let getEventsFromArray = (partyItemsArray[i] as? PartyItem)
            let listOfPartyItems = getEventsFromArray?.itemName
            
            

            
            // Writing the list of events to firebase database
            //newFirebaseManager.ref.child("events").child("\(firebaseUserID)").child("\(eventID)").child("stripe_user_id").setValue("\(stripeUserID)")
            
            
            newFirebaseManager.ref.child("events").child("\(eventID)").child("party_item_list").child("\(listOfPartyItems!)").setValue(listOfPartyItems!)
        }
    }

    class func writeToFirebaseDBHostStripeUserID(partyItemName : String, eventID : String) {
        
        let newFirebaseManager = FirebaseManager()
        
        newFirebaseManager.ref = FIRDatabase.database().reference()
    
        guard let stripeUserID = UserDefaults.standard.object(forKey: "stripe_id") as? String else {
            print("There is an issue writing Hosts Stripe User ID to Firebase DB")
            return
        }
        
        /* Writing the host's Stripe User ID to Firebase database */
        newFirebaseManager.ref.child("hosts-stripe-user-id").child("\(eventID)").child("stripe_user_id").setValue("\(stripeUserID)")
        
    }
    
    class func retrievePartyItemsFromFirebase(eventID :String, completion:@escaping([String]) -> Void){
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()

        var partyItemNameArray = [String]()
        //var partyEventIDArray = [String]()
        
        ref.child("party_item_list").child("\(eventID)").child("party_item_name").observe(.childAdded, with: { (snapshot) in
            
            if !snapshot.exists() {
                print("No snapshot exists")
                return
            }
            partyItemNameArray.append((snapshot.value as? String)!)
            //print(partyItemNameArray)
            
            completion(partyItemNameArray)
        })
    }
    
    class func retrieveEventIDFromFirebase(eventID :String, completion:@escaping([String]) -> ()){
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        var partyEventIDArray = [String]()
        
        ref.child("party_item").child((UserDefaults.standard.object(forKey: "uid") as? String)!).child("\(eventID)").child("party_item_event_id").observe(.childAdded, with: { (snapshot) in
            
            if !snapshot.exists() {
                print("No snapshot exists")
                return
            }
            
            partyEventIDArray.append((snapshot.value as? String)!)
            //print(partyEventIDArray)
            completion(partyEventIDArray)
        })
    }
    
    class func retrievePartyItemsGoalFromFirebase(eventID :String, completion:@escaping([NSNumber]) -> Void){

        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        var partyItemGoalArray = [NSNumber]()
        

        ref.child("party_item").child((UserDefaults.standard.object(forKey: "uid") as? String)!).child("\(eventID)").child("party_item_goal").observe(.childAdded, with: { (snapshot) in
        
            if !snapshot.exists() {
                print("No snapshot exists")
                return
            }
            
            partyItemGoalArray.append((snapshot.value as? NSNumber)!)
            print(partyItemGoalArray)

            completion(partyItemGoalArray)
        })
    }
    
    class func retrievePartyItemsGoalFromFirebase2(listOfPartyItems: String, eventID :String, completion:@escaping([NSNumber]) -> Void){
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        var partyItemGoalArray = [NSNumber]()
        
        
        ref.child("party_item_goal").child("\(listOfPartyItems)").child("\(eventID)").child((UserDefaults.standard.object(forKey: "uid") as? String)!).observe(.childAdded, with: { (snapshot) in
            
            //        ref.child("party_item").child((UserDefaults.standard.object(forKey: "uid") as? String)!).child("\(eventID)").child("party_item_goal").observe(.childAdded, with: { (snapshot) in
            
            if !snapshot.exists() {
                print("No snapshot exists")
                return
            }
            
            partyItemGoalArray.append((snapshot.value as? NSNumber)!)
            print(partyItemGoalArray)
            
            completion(partyItemGoalArray)
        })
    }

    class func retrievePartyItemsImagePathsFromFirebase(eventID :String, completion:@escaping([String]) -> Void){
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        var partyItemImagePathArray = [String]()
        
        ref.child("party_item").child((UserDefaults.standard.object(forKey: "uid") as? String)!).child("\(eventID)").child("party_item_image_path").observe(.childAdded, with: { (snapshot) in
            
            if !snapshot.exists() {
                print("No snapshot exists")
                return
            }
            
            partyItemImagePathArray.append((snapshot.value as? String)!)
            print(partyItemImagePathArray)
            
            completion(partyItemImagePathArray)
        })
    }
    
    class func writeToFirebaseDBPartyItemImages(partyItemName : String, eventID : String, partyItemsArray : Array<Any>?) {
        
        let newFirebaseManager = FirebaseManager()
        
        newFirebaseManager.ref = FIRDatabase.database().reference()
        
        var data: NSData = NSData()
        
        guard let partyItemsArray = partyItemsArray else {
            print("There is an issue")
            return
        }
        
        for i in 0..<partyItemsArray.count {
            
            let getEventsFromArray = (partyItemsArray[i] as? PartyItem)
            let listOfPartyItems = getEventsFromArray?.itemName
            
            
            let listOfItemImages = getEventsFromArray?.itemImage
            
            let imageData: NSData = UIImageJPEGRepresentation(listOfItemImages!, 0.4)! as NSData
            let strBase64 = imageData.base64EncodedString(options: .init(rawValue: 0))
            
            
            
            newFirebaseManager.ref.child("party_item_images").child("\(eventID)").child("\(listOfPartyItems!)").setValue(strBase64)
            
        }
    }
    
    class func retrievePartyItemImages(partyItemName : String, eventID : String, completion: @escaping ([String])->())
    {
        var partyItemImagePathArray = [String]()

        var ref: FIRDatabaseReference!

        ref = FIRDatabase.database().reference()

        ref.child("party_item_images").child("\(eventID)").observe(.childAdded, with: { snapshot in
            
            
            
            if !snapshot.exists() {
                print("No snapshot exists")
                return
            }
        
            partyItemImagePathArray.append((snapshot.value as? String)!)
            print(partyItemImagePathArray)
            completion(partyItemImagePathArray)

        })
    }

    class func retrieveHostStripeUserID(eventID :String, completion:@escaping(String) -> Void){
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        ref.child("hosts-stripe-user-id").child("\(eventID)").observe(.childAdded, with: { (snapshot) in

            if !snapshot.exists() {
                print("No snapshot exists")
                return
            }
            //print("PRINT STRIPE_USERID---------","\(snapshot.value!)")
            completion(snapshot.value as! String)
        })

    }
}
