//
//  AttendingGoalsTableViewCell.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

var arrayOfPartyItemNames = [String]()

class GoalsTableViewCell: UITableViewCell {

    @IBOutlet weak var attendingGoalNameLabel: UILabel!
    
    @IBOutlet weak var attendingGoalProgressView: UIProgressView!
    @IBOutlet weak var attendingGoalAmountFundedLabel: UILabel!
    
    @IBOutlet weak var attendingGoalImageContainerView: UIView!
    @IBOutlet weak var attendingGoalImageView: UIImageView!
    
    var cellPartyItem:PartyItem?
    
    let fireBaseManager = FirebaseManager()
    
    var fundedString = ""
    
    var arrayOfEventIDs = [String]()

//    var arrayOfPartyItemNames = [String]()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setImageView()
        
        
        
    }

    func getEventIDsFromFirebase(event: Event) -> Void {
        
        FirebaseManager.retrieveEventIDFromFirebase(eventID: event.eventID!)  { (eventIDArray) -> () in
            
            self.arrayOfEventIDs = eventIDArray
            print("List of Event IDs in DUMMY FUNCTION:","\(self.arrayOfEventIDs)")
            
            
            
            
        }
        
        //return self.arrayOfEventIDs
        
    }


    func configureCellWith(event:Event, indexPath:Int) -> Void
    {
    
        //var arrayOfPartyItemNames = [String]()
        var arrayOfEventIDs = [String]()
        var arrayOfPartyItemGoals = [NSNumber]()
        
        
        var dummyArray = [String]()
        
        getEventIDsFromFirebase(event: event)
        
        print("\(dummyArray)")
        
        FirebaseManager.retrievePartyItemsFromFirebase(eventID: event.eventID!) { (partyItemArray) in
            
            arrayOfPartyItemNames = partyItemArray
            
        }
        
        FirebaseManager.retrieveEventIDFromFirebase(eventID: event.eventID!)  { (eventIDArray) in
            
            arrayOfEventIDs = eventIDArray
            
        }
        FirebaseManager.retrievePartyItemsGoalFromFirebase(eventID: event.eventID!)  { (partyItemGoalArray) in
            
            arrayOfPartyItemGoals = partyItemGoalArray
            
        }

        
//        FirebaseManager.retrieveEventIDFromFirebase(eventID: event.eventID!)  { (eventIDArray) -> () in
//            
//            self.arrayOfEventIDs = eventIDArray
//            print("List of Event IDs in DUMMY FUNCTION:","\(self.arrayOfEventIDs)")
//            
//            if self.arrayOfEventIDs.count != 0 {
//
//                //self.cellPartyItem = event.partyItems[indexPath]
//                self.attendingGoalNameLabel.text = self.arrayOfEventIDs[0]
//
//            }
//            
//            
//        }
        
        FirebaseManager.retrievePartyItemsFromFirebase(eventID: event.eventID! ) { (partyItemNameArray) -> () in
            
            arrayOfPartyItemNames = partyItemNameArray
            
            if arrayOfPartyItemNames.count != 0 {
                
                for i in 0..<arrayOfPartyItemNames.count {
                    
                self.attendingGoalNameLabel.text = arrayOfPartyItemNames[i]
                }
                
            }
            
            
        }
        
        print("\(arrayOfPartyItemNames)")
        print("\(arrayOfEventIDs)")
        print("\(arrayOfPartyItemGoals)")

//        if event.partyItems.count != 0 {
//            
//            cellPartyItem = event.partyItems[indexPath]
//            attendingGoalNameLabel.text = cellPartyItem?.itemName
//            
//            if cellPartyItem?.itemAmountFunded == nil {
//                fundedString = "0% there!"
//                
//            }else{
//                
//                fundedString = "\(cellPartyItem?.itemAmountFunded)% there!"
//                
//            }
//            
//            attendingGoalAmountFundedLabel.text = fundedString
//            
//            setUpProgressBarWith(partyItem:cellPartyItem!)
//            
//        }else{
//            
//            self.attendingGoalNameLabel.text = "Sorry, there are no PartyItems to contribute to for this event!"
//            
//        }
        
    }
    
    func setImageView() -> Void
    {
        
        attendingGoalImageContainerView.layer.borderWidth = 1
        attendingGoalImageContainerView.layer.masksToBounds = false
        attendingGoalImageContainerView.layer.borderColor = UIColor.black.cgColor
        attendingGoalImageContainerView.layer.cornerRadius = attendingGoalImageView.frame.width/2
        attendingGoalImageContainerView.clipsToBounds = true
        
    }

    func setUpProgressBarWith(partyItem:PartyItem) -> Void
    {
    
        guard partyItem.itemAmountFunded != nil && partyItem.itemAmountFunded != 0 else{
            
            attendingGoalProgressView.setProgress(0.0, animated: false)
            return
            
        }
        
        let currentProgress = partyItem.itemAmountFunded!/partyItem.itemGoal!
        
        attendingGoalProgressView.setProgress(Float(currentProgress), animated: true)

        
        
    }

}
