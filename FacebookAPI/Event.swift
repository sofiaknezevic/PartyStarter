//
//  Event.swift
//  FacebookAPI
//
//  Created by Scott Hetland on 2017-03-23.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class Event: NSObject {
    
    var eventDescription: String?
    var endTime: String?
    var eventName: String?
    var placeName: String?
    var cityName: String?
    var countryName: String?
    var latitute: Double?
    var longitude: Double?
    var state: String?
    var street: String?
    var zipCode: String?
    var placeID: String?
    var startTime: String?
    var rsvpStatus: String?
    
    var eventID: String?
    
    //the thing that the host wants to get people to pitch money for! To get the partySTARTED!
    var partyItems = [PartyItem]()
        
    //cover photo for event from facebook
    var coverPhoto: UIImage?
    
    //array of admin and attendee objects
    var admins: Array<Admins>?
    var attendees: Array<Attendees>?
    
    var stripeID = String()

    //this parse is used to get most of the data for the event
    class func parseDataFromJSON( _ json: [String: Any]) -> Event {

        let newEvent = Event()
        
        //ones that are not nested
        newEvent.eventDescription = json["description"] as? String
        newEvent.endTime = json["end_time"] as? String
        newEvent.eventName = json["name"] as? String
        newEvent.startTime = json["start_time"] as? String
        newEvent.eventID = json["id"] as? String
        newEvent.rsvpStatus = json["rsvp_status"] as? String
        
        //nested in place
        if let place = json["place"] as? [String:Any] {
        newEvent.placeName = place["name"] as? String
        newEvent.placeID = place["id"] as? String
        }
        
        //nested in location
        if let place = json["place"] as? [String:Any] {
            if let location = place["location"] as? [String:Any] {
                newEvent.cityName = location["city"] as? String
                newEvent.countryName = location["country"] as? String
                newEvent.latitute = location["latitude"] as? Double
                newEvent.longitude = location["longitude"] as? Double
                newEvent.state = location["state"] as? String
                newEvent.street = location["street"] as? String
                newEvent.zipCode = location["zip"] as? String
            }
        }
        
        return newEvent
    }
        
}

