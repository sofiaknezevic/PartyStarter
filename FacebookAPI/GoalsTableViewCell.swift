//
//  AttendingGoalsTableViewCell.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class GoalsTableViewCell: UITableViewCell {

    @IBOutlet weak var attendingGoalNameLabel: UILabel!
    
    @IBOutlet weak var attendingGoalProgressView: UIProgressView!
    @IBOutlet weak var attendingGoalAmountFundedLabel: UILabel!
    
    @IBOutlet weak var attendingGoalImageContainerView: UIView!
    @IBOutlet weak var attendingGoalImageView: UIImageView!
    
    var cellPartyItem:PartyItem?
    
    let fireBaseManager = FirebaseManager()
    
    var fundedString = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setImageView()
        
        
        
    }


    func configureCellWith(event:Event, indexPath:Int) -> Void
    {
    
        var arrayOfPartyItemNames = [String]()
        var arrayOfEventIDs = [String]()
        var arrayOfPartyItemGoals = [NSNumber]()
        
        
        FirebaseManager.retrievePartyItemsFromFirebase(eventID: event.eventID!) { (partyItemArray) in
            
            arrayOfPartyItemNames = partyItemArray
            
        }
        
        FirebaseManager.retrieveEventIDFromFirebase(eventID: event.eventID!)  { (eventIDArray) in
            
            arrayOfEventIDs = eventIDArray
            
        }
        FirebaseManager.retrievePartyItemsGoalFromFirebase(eventID: event.eventID!)  { (partyItemGoalArray) in
            
            arrayOfPartyItemGoals = partyItemGoalArray
            
        }

        print("\(arrayOfPartyItemNames)")
        print("\(arrayOfEventIDs)")
        print("\(arrayOfPartyItemGoals)")

        if event.partyItems.count != 0 {
            
            cellPartyItem = event.partyItems[indexPath]
            attendingGoalNameLabel.text = cellPartyItem?.itemName
            
            if cellPartyItem?.itemAmountFunded == nil {
                fundedString = "0% there!"
                
            }else{
                
                fundedString = "\(cellPartyItem?.itemAmountFunded)% there!"
                
            }
            
            attendingGoalAmountFundedLabel.text = fundedString
            
            setUpProgressBarWith(partyItem:cellPartyItem!)
            
        }else{
            
            self.attendingGoalNameLabel.text = "Sorry, there are no PartyItems to contribute to for this event!"
            
        }
        
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
