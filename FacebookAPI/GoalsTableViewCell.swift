//
//  AttendingGoalsTableViewCell.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

var arrayOfPartyItemNames = [String]()

//get an array of party items to write to the cell
var arrayOfPartyItems = [PartyItem]()

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
    
    @IBOutlet weak var fundedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fundedLabel.isHidden = true
        
    }
    
    
    func configureCellWithPartyItem(partyItem:PartyItem) -> Void {
        
        fundedLabel.isHidden = true

        attendingGoalNameLabel.text = partyItem.itemName
        setImageView(itemImage: partyItem.itemImage!)
        
        //hard coded until we can get the actual value
        let amountFunded:Int = Int(partyItem.itemAmountFunded!)
        let itemGoal = Int(partyItem.itemGoal!)
        print(itemGoal)
        let progress = Double(amountFunded)/Double(itemGoal)
        self.attendingGoalProgressView.setProgress(Float(progress), animated: true)
        self.attendingGoalAmountFundedLabel.text = "Funded: $\(amountFunded) Goal: $\(itemGoal)"
        
        //when the amount funded is greater than or equal to the goal put a checkmark in the cell
        if (amountFunded >= itemGoal) {
            fundedLabel.text = "👍"
            fundedLabel.isHidden = false
            attendingGoalAmountFundedLabel.text = "Fully Funded! $\(amountFunded)"
        }

        
    }
    
    func configureCellWithSadClown(partyItem:PartyItem) -> Void {
        
        attendingGoalNameLabel.text = partyItem.itemName
        setImageView(itemImage: partyItem.itemImage!)
        
        if (partyItem.eventID == "attendingEvent") {
        
        attendingGoalAmountFundedLabel.text = ""
            fundedLabel.text = "👎"
            fundedLabel.isHidden = false
        } else {
          attendingGoalAmountFundedLabel.text = "Get the party started! 👆"
        fundedLabel.isHidden = true
        }
        
    }
    
    //call this function when configuring the cell, pass in the item's image
    func setImageView(itemImage: UIImage) -> Void {
        
        attendingGoalImageContainerView.layer.borderWidth = 2
        attendingGoalImageContainerView.layer.masksToBounds = true
        attendingGoalImageContainerView.layer.borderColor = UIColor.black.cgColor
        attendingGoalImageContainerView.layer.cornerRadius = attendingGoalImageView.frame.width

        attendingGoalImageContainerView.clipsToBounds = true
        
        //need to grab the image from firebase
        attendingGoalImageView.image = itemImage
        
    }

    func setUpProgressBarWith(partyItem:PartyItem) -> Void {
    
        guard partyItem.itemAmountFunded != nil && partyItem.itemAmountFunded != 0 else{
            
            attendingGoalProgressView.setProgress(0.0, animated: false)
            return
        }
        
        let currentProgress = partyItem.itemAmountFunded!/partyItem.itemGoal!
        
        attendingGoalProgressView.setProgress(Float(currentProgress), animated: true)
    }
    
    
    //                //hard coding but replace with actual values
    //                let amountFunded:Int = 5
    //                let itemGoal:Int = 10
    //                let progress = Double(amountFunded)/Double(itemGoal)
    //                self.attendingGoalProgressView.setProgress(Float(progress), animated: true)
    
    //                self.attendingGoalAmountFundedLabel.text = "Funded: $\(amountFunded) Goal: $\(itemGoal)"
    
    //pass in actual image instead
    //                let sampleImage:UIImage = #imageLiteral(resourceName: "cake")
    
    //                self.setImageView(itemImage: sampleImage)
    
    
    //set the image view to the items image
    //self.attendingGoalImageView.image = arrayOfpartyItems[indexPath].itemImage
    //let progressAmount = arrayOfPartyItems[indexPath].itemAmountFunded / arrayOfPartyItems[indexPath].itemGoal
    //self.attendingGoalProgressView.progress = progressAmount
    
    
    //should use the function instead of all here

}
