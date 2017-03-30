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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setImageView()
        
        
        
    }


    func configureCellWith(event:Event?, indexPath:Int) -> Void
    {
        
        print("*********")
        print(event)

        if event?.partyItems.count != nil && event?.partyItems.count != 0 {
            
            cellPartyItem = event?.partyItems[indexPath]
            attendingGoalNameLabel.text = cellPartyItem?.itemName
            
            let fundedString = "\(cellPartyItem?.itemAmountFunded)% there!"
            
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
        let currentProgress = partyItem.itemAmountFunded!/partyItem.itemGoal!
        
        attendingGoalProgressView.setProgress(Float(currentProgress), animated: true)
        
        
    }

}
