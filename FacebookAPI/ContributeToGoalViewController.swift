//
//  ContributeToGoalViewController.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-28.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import Stripe

protocol StripeInformationDelegate:class {
    
    func retrieveStripeID(stripeID:String)
    func retrieveAmount(amount:Int)
    
}

class ContributeToGoalViewController: UIViewController, ChargeNotificationDelegate{
    
    @IBOutlet weak var contributionButton: UIButton!
    
    @IBOutlet weak var goalAmountLabel: UILabel!
    @IBOutlet weak var goalAmountMinusContributionLabel: UILabel!
    
    @IBOutlet weak var amountToContributeSlider: UISlider!
    
    @IBOutlet weak var amountToContributeLabel: UILabel!
    
    weak var delegate:StripeInformationDelegate?
    
    var partyItemToContributeTo:PartyItem?
    
    var arrayOfContributors = [String]()
    
    var eventToContributeTo = Event()
    
    var hostStripeUserID : String?
    
    var itemContribution = Int()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUp()
        
    }
    
    func setUp() -> Void {
        
        let unwrappedGoalAmount = (partyItemToContributeTo?.itemGoal)! as Double
        goalAmountLabel.text = "PartyItem Goal: $\(unwrappedGoalAmount)"
        
        
    }
    
    func getAlert(notifier: Int) -> Void
    {
        
        var title: String?
        var message: String?
        switch notifier {
        case 0:
            title = "Error"
            message = "Something went wrong with your transaction! 🤦‍♂️"
        case 1:
            title = "Success"
            message = "You've helped get this PartyStarted!! 💃"
        default:
            return
       
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        
        amountToContributeSlider.reloadInputViews()
        
    }
    
    @IBAction func contributionButtonPressed(_ sender: UIButton)
    {
        //go to viewcontroller that deals with creditcard information and get it all done, using the stripeuserid from the host and the token from the credit card of the attendee
        
        performSegue(withIdentifier: "goToPaymentVC", sender: self)

        
    }
    
    @IBAction func amountToContributeSlider(_ sender: UISlider)
    {
        itemContribution = Int(amountToContributeSlider.value)
        
        let partyItemGoal = Int((partyItemToContributeTo?.itemGoal)!)
        
        contributionButton.setTitle("Contribute $\(itemContribution)", for: UIControlState.normal)
        
        amountToContributeLabel.text = "$\(itemContribution)"

        goalAmountMinusContributionLabel.text = "$\(partyItemGoal - itemContribution) left until goal is reached!"
    }

    func getHostStripeUserID() {
        
        FirebaseManager.retrieveHostStripeUserID(eventID: (eventToContributeTo.eventID!)) { (returnedHostStripeUserID) -> () in
            
            self.hostStripeUserID = returnedHostStripeUserID
            
            self.delegate?.retrieveStripeID(stripeID: self.hostStripeUserID!)
            
            self.delegate?.retrieveAmount(amount: self.itemContribution)
            
            print("HOST STRIPE-USER-ID", self.hostStripeUserID!)
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToPaymentVC" {
            
            getHostStripeUserID()
            
            let navigation = segue.destination as! UINavigationController
            let newPaymentVC = navigation.topViewController as! PaymentViewController
            newPaymentVC.chargeNotificationDelegate = self
            self.delegate = newPaymentVC
            
            
        }
        
    }
    


    
}
