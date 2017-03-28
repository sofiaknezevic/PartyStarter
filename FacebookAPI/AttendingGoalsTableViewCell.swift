//
//  AttendingGoalsTableViewCell.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class AttendingGoalsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var attendingGoalsImageView: UIImageView!

    @IBOutlet weak var attendingGoalsLabel: UILabel!
    @IBOutlet weak var attendingGoalsProgressBar: UIProgressView!
    @IBOutlet weak var attendingGoalsPercentFundedLabel: UILabel!
    @IBOutlet weak var attendingGoalsContributorsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }


    func configureCellWith(event:Event?, partyItem:PartyItem) -> Void
    {
        if event != nil{
            
            attendingGoalsImageView.image = event?.coverPhoto
            attendingGoalsLabel.text = event?.eventName
            
        }else{
            
            attendingGoalsLabel.text = "Sorry there are no PartyItems you can contribute to for this event!"
            
        }
        

        
    
        
    }
    
    func setImageView() -> Void
    {
        
        
        
    }

    func setUpProgressBar() -> Void
    {
        
        
        
    }

}
