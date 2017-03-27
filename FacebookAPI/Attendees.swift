//
//  Attendees.swift
//  FacebookAPI
//
//  Created by Scott Hetland on 2017-03-26.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class Attendees: NSObject {
    
    var attendeeName:String?
    var attendeeID:String?
    
    class func parseAttendeesFromJSON( _ json: [String: Any]) -> Attendees {
        
        let newAttendee = Attendees()
        
        newAttendee.attendeeName = json["name"] as? String
        newAttendee.attendeeID = json["id"] as? String
        
        return newAttendee

    }

}
