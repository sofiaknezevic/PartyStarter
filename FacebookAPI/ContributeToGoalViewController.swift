//
//  ContributeToGoalViewController.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-28.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import Stripe

class ContributeToGoalViewController: UIViewController{
    
    @IBOutlet weak var goalAmountLabel: UILabel!
    @IBOutlet weak var goalAmountMinusContributionLabel: UILabel!
    
    @IBOutlet weak var amountToContributeSlider: UISlider!
    
    
    let backendBaseURL: String? = "http://localhost:4567/"
    
    //var paymentContext:STPPaymentContext?
   // let paymentCurrency = "cad"
    var jsonOfHost:[String:Any]?
    
    var stripePublishableKey:String?
    
    var partyItemToContributeTo:PartyItem?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        
    }
    
    func setUp() -> Void {
        
        goalAmountLabel.text = "\(partyItemToContributeTo?.itemGoal)"
        
        
    }
    

    @IBAction func contributionButtonPressed(_ sender: UIButton)
    {
        
        
        
        
        
    }
    
    @IBAction func amountToContributeSlider(_ sender: UISlider)
    {
        
        
        
    }



}
