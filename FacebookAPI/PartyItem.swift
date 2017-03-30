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
    var itemContributors:[String]?
    var itemImage:UIImage?
    var itemAmountFunded:Double?
    
    var eventID:String?
    
    init(name:String, goal:Double, image:UIImage, itemEventID:String) {
        
        itemName = name
        itemGoal = goal
        itemImage = image
        eventID = itemEventID
        
    }
    
    func updateContributorsAndAmountFunded(contributors:[String], amountFunded:Double){
    
        itemContributors = contributors
        itemAmountFunded = amountFunded
        
    }
    

}
