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

    func configureCellWith(event:Event, indexPath:Int) -> Void {
        
        FirebaseManager.retrievePartyItemsFromFirebase(eventID: event.eventID! ) { (partyItemNameArray) -> () in
            
            arrayOfPartyItemNames = partyItemNameArray
            
            DispatchQueue.main.async {
                
                self.attendingGoalNameLabel.text = arrayOfPartyItemNames[indexPath]
            }
        }
    }
    
    func configureCellWithPartyItem(partyItem:PartyItem) -> Void {
        
    }
    
    func setImageView() -> Void {
        
        attendingGoalImageContainerView.layer.borderWidth = 2
        attendingGoalImageContainerView.layer.masksToBounds = true
        attendingGoalImageContainerView.layer.borderColor = UIColor.black.cgColor
        attendingGoalImageContainerView.layer.cornerRadius = attendingGoalImageView.frame.width
        attendingGoalImageContainerView.clipsToBounds = true        
    }

    func setUpProgressBarWith(partyItem:PartyItem) -> Void {
    
        guard partyItem.itemAmountFunded != nil && partyItem.itemAmountFunded != 0 else{
            
            attendingGoalProgressView.setProgress(0.0, animated: false)
            return
        }
        
        let currentProgress = partyItem.itemAmountFunded!/partyItem.itemGoal!
        
        attendingGoalProgressView.setProgress(Float(currentProgress), animated: true)
    }

}
