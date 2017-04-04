//
//  PartyItem.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class PartyItem: NSObject {
    
    var itemName:String?
    var itemGoal:Double?
    var itemImage:UIImage?
    var eventID:String?
    var itemAmountFunded:Double?
    
    
    init(name:String, goal:Double, image:UIImage, itemEventID:String, amountFunded:Double) {
        
        itemName = name
        itemGoal = goal
        itemImage = image
        eventID = itemEventID
        itemAmountFunded = amountFunded
    }
    

    

}
