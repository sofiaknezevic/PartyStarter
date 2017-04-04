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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        setImageView()
        
        //where do we set up the cell?
        
    }
    
    
    func configureCellWithPartyItem(partyItem:PartyItem) -> Void {
        
        attendingGoalNameLabel.text = partyItem.itemName
        
        //let itemGoal = Int(partyItem.itemGoal!)
        
        
        
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
