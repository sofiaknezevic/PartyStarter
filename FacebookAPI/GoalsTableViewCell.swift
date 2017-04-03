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


    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setImageView()
        
        
        
    }

    func getEventIDsFromFirebase(event: Event) -> Void {
        
        FirebaseManager.retrieveEventIDFromFirebase(eventID: event.eventID!)  { (eventIDArray) -> () in
            
            self.arrayOfEventIDs = eventIDArray
            print("List of Event IDs in DUMMY FUNCTION:","\(self.arrayOfEventIDs)")
            
            
            
            
        }
        
        
    }


    func configureCellWith(event:Event, indexPath:Int) -> Void
    {

        var cellPartyItemName = String()
        var cellPartyItemGoal = Double()
        var cellPartyItemImage = UIImage()
        var cellPartyItemEventID = String()
 
        
        FirebaseManager.retrievePartyItemsFromFirebase(eventID: event.eventID!) { (partyItemArray) in
            
  
            
            
            
            
        }
        
      
        


    }
    
    func configureCellWithPartyItem(partyItem:PartyItem) -> Void
    {
        
    
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
