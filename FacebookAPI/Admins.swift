//
//  Admins.swift
//  FacebookAPI
//
//  Created by Scott Hetland on 2017-03-26.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class Admins: NSObject {
    
    var adminName:String?
    var adminID:String?
    var adminEventID: String?
    
      class func parseAdminsFromJSON( _ json: [String: Any]) -> Admins {
        
        let newAdmin = Admins()
        
        newAdmin.adminName = json["name"] as? String
        newAdmin.adminID = json["id"] as? String
        
        return newAdmin
        
    }
}
