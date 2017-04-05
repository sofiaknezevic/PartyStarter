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
        let writeHostingArrayToFirebaseDB = newFirebaseManager.ref.child("user_profile").child(firebaseUserID).child("hosting_events_array")
        
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
        
        
        let writeAttendingArrayToFirebaseDB = newFirebaseManager.ref.child("user_profile").child(firebaseUserID).child("attending_events_array")
        
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
            return
        }
        
        // Writing the list of events to firebase database
        let writeToFirebaseDB = newFirebaseManager.ref.child("user_profile").child(firebaseUserID).child("user_name")
        
        writeToFirebaseDB.setValue(userName)
    }
    
    //MARK: AmountFunded
    
    class func writeToFirebaseDBAmountFunded(partyItem:PartyItem)
    {
        let newFirebaseManager = FirebaseManager()
        
        newFirebaseManager.ref = FIRDatabase.database().reference()
        
        newFirebaseManager.ref.child("party_item_amountFunded").child(partyItem.itemName!).child(partyItem.eventID!).setValue(partyItem.itemAmountFunded)
        
    }
    
    class func retrieveAmountFunded(partyItemName:String, eventID:String, completion:@escaping(NSNumber) -> Void)
    {
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        var partyItemAmountFunded:NSNumber?

        ref.child("party_item_amountFunded").child(partyItemName).child(eventID).observe(.value, with: { (snapshot) in
            
            if !snapshot.exists(){
                
                print("No amount funded exists!!")
                
                partyItemAmountFunded = 0
   
            }else{
                
                partyItemAmountFunded = snapshot.value as? NSNumber
                
            }
            

            
            completion(partyItemAmountFunded!)
            
        })
    }
    
    class func writeToFirebaseDBPartyItem(partyItemName : String, eventID : String, partyItemsArray : Array<Any>?) {
        
        let newFirebaseManager = FirebaseManager()
        
        newFirebaseManager.ref = FIRDatabase.database().reference()
    
        guard let partyItemsArray = partyItemsArray, let firebaseUserID = UserDefaults.standard.object(forKey: "uid") as? String else {
            return
        }
        
        for i in 0..<partyItemsArray.count {
            
            let getEventsFromArray = (partyItemsArray[i] as? PartyItem)
            let listOfPartyItems = getEventsFromArray?.itemName
            let listOfGoals = getEventsFromArray?.itemGoal
            
            let convertToNSNumber: NSNumber = NSNumber(value: listOfGoals!)
            
            let listOfItemImages = getEventsFromArray?.itemImage
            
            let imageData:NSData = UIImagePNGRepresentation(listOfItemImages!)! as NSData
            
            
            
            let strBase64 = imageData.base64EncodedString(options: .init(rawValue: 0))
            
            
            /* Writing the list of party item list under event id */
            newFirebaseManager.ref.child("party_item_list").child(eventID).child("party_item_name").child(listOfPartyItems!).setValue(listOfPartyItems)
            
            /* Writing the list of party item goal amount */
            newFirebaseManager.ref.child("party_item_goal").child(listOfPartyItems!).child(eventID).child(firebaseUserID).setValue(convertToNSNumber)
            
            /* Writing the list of party item images */
            newFirebaseManager.ref.child("party_item_image").child(eventID).child("base64_images").child(listOfPartyItems!).setValue(strBase64)
        }
    }
    
    class func writeToFirebaseDBEvents(partyItemName : String, eventID : String, partyItemsArray : Array<Any>?) {
        
        let newFirebaseManager = FirebaseManager()
        
        newFirebaseManager.ref = FIRDatabase.database().reference()
        
        guard let partyItemsArray = partyItemsArray else {
            return
        }
        
        for i in 0..<partyItemsArray.count {
            
            let getEventsFromArray = (partyItemsArray[i] as? PartyItem)
            let listOfPartyItems = getEventsFromArray?.itemName
            
            newFirebaseManager.ref.child("events").child(eventID).child("party_item_list").child(listOfPartyItems!).setValue(listOfPartyItems!)
        }
    }
    
    class func writeToFirebaseDBHostStripeUserID(eventID : String) {
        
        let newFirebaseManager = FirebaseManager()
        
        newFirebaseManager.ref = FIRDatabase.database().reference()
        
        guard let stripeUserID = UserDefaults.standard.object(forKey: "stripe_id") as? String else {
            print("There is an issue writing Hosts Stripe User ID to Firebase DB")
            return
        }
        
        /* Writing the host's Stripe User ID to Firebase database */
        newFirebaseManager.ref.child("hosts-stripe-user-id").child(eventID).child("stripe_user_id").setValue(stripeUserID)
    }
    
    class func retrievePartyItemsFromFirebase(eventID :String, completion:@escaping([PartyItem]) -> Void) {
   
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        //        var partyItemNameArray = [String]()
        //var partyEventIDArray = [String]()
        
        //test these to see if the networking works
        var partyArray = [PartyItem]()
    
        
        //get party item name
        ref.child("party_item_list").child(eventID).child("party_item_name").observe(.childAdded, with: { (snapshot) in
            
            if !snapshot.exists() {
                print("No snapshot exists for party item name")
                return
            }
            
            let partyItemName:String? = snapshot.value as? String
 
            retrievePartyItemGoal(partyName: partyItemName!, eventID: eventID, completion: { (partyItemGoal) in
                
                
                retrievePartyItemImages(eventID: eventID, partyItemName: partyItemName!) { (partyItemImageString) -> () in
                    
                 
                    retrieveAmountFunded(partyItemName: partyItemName!, eventID: eventID) { (partyItemAmountFunded) -> () in
  
                    //set the itemamounthere
                    let partyItemImageString = String(partyItemImageString)
                        
                    let realAmountFunded = Double(partyItemAmountFunded)
                    
                    let strBase64 = partyItemImageString
                    let dataDecoded:NSData = NSData(base64Encoded: strBase64!, options: NSData.Base64DecodingOptions(rawValue: 0))!
                    let decodedImage:UIImage = UIImage(data: dataDecoded as Data)!
                
                    let itemGoal = Double(partyItemGoal)
                    
                    let newPartyItem = PartyItem.init(name: partyItemName!,
                                                      goal: itemGoal,
                                                      image: decodedImage,
                                                      itemEventID: eventID,
                                                      amountFunded: realAmountFunded)
                    
                    partyArray.append(newPartyItem)
                    
                    completion(partyArray)
                        
                    }
                }
            })
        })
    }
    
    class func retrievePartyItemGoal(partyName:String, eventID:String, completion:@escaping(NSNumber) -> Void) {
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        var partyItemGoal:NSNumber?
        
        ref.child("party_item_goal").child(partyName).child(eventID).observe(.childAdded, with: { (snapshot) in
            
            if !snapshot.exists() {
                print("No snapshot exists for party item goal")
                return
            }
            
            partyItemGoal = snapshot.value as? NSNumber
            
            completion(partyItemGoal!)
        })
    }

    class func retrievePartyItemImages(eventID : String, partyItemName: String, completion: @escaping (String)->())
    {
        var partyItemImagePath = String()
        
        var ref: FIRDatabaseReference!
        
        ref = FIRDatabase.database().reference()

        
        ref.child("party_item_image").child(eventID).child("base64_images").child(partyItemName).observe(.value, with: { snapshot in

            
            if !snapshot.exists() {
                print("No snapshot exists for party item image strings")
                return
            }
            
            partyItemImagePath = snapshot.value as! String
            
            completion(partyItemImagePath)
    
        })
    }
    
    class func retrieveHostStripeUserID(event:Event, completion:@escaping(String) -> Void){
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        ref.child("hosts-stripe-user-id").child(event.eventID!).observe(.childAdded, with: { (snapshot) in
            
            if !snapshot.exists() {
                print("No snapshot exists for stripe user id for host")
                return
            }
            print("PRINT STRIPE_USERID---------","\(snapshot.value!)")
            event.stripeID = snapshot.value as! String
            completion(snapshot.value as! String)
        })
        
    }
    
    class func deletePartyItemListOfItem(firstTree: String, secondTree: String, childIWantToRemove: String) {
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        ref.child("party_item_list").child(firstTree).child(secondTree).child(childIWantToRemove).removeValue { (error, ref) in
            if error != nil {
                print("error \(error)")
            }
        }
    }
    
    class func deletePartyItemImage(firstTree: String, secondTree: String, childIWantToRemove: String) {
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        ref.child("party_item_image").child(firstTree).child(secondTree).child(childIWantToRemove).removeValue { (error, ref) in
            if error != nil {
                print("error \(error)")
            }
        }
    }

}
