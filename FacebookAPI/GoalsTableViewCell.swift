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
        
        print(FirebaseManager.retrievePartyItemsFromFirebase(eventID: event.eventID!))
        //event.partyItems.append(FirebaseManager.retrievePartyItemsFromFirebase(eventID: event.eventID!)) as! [PartyItem]

        //FirebaseManager.retrievePartyItems(eventID: event.eventID!)
        
        event.partyItems = FirebaseManager.retrievePartyItemsFromFirebase(eventID: event.eventID!) as Array<Any> as! [PartyItem]


        
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        var postData = [Any]()
        
        ref.child("party_item").child((UserDefaults.standard.object(forKey: "uid") as? String)!).child("\(String(describing: event.eventID))").child("party_item_list").observe(.childAdded, with: { (snapshot) in
            
            if !snapshot.exists() {
                print("No snapshot exists")
                return
            }
            
            postData.append((snapshot.value as? String)!)
            
            event.partyItems = postData as! [PartyItem]
        })
        

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
            
            attendingGoalProgressView.setProgress(0, animated: false)
            return
            
        }
        
        let currentProgress = partyItem.itemAmountFunded!/partyItem.itemGoal!
        
        attendingGoalProgressView.setProgress(Float(currentProgress), animated: true)

        
        
    }

}
