//
//  ContributeToGoalViewController.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-28.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import Stripe

//MARK: - Protocol -

protocol StripeInformationDelegate:class {
    
    func retrieveStripeID(stripeID:String)
    func retrieveAmount(amount:Int)
    
}

class ContributeToGoalViewController: UIViewController, ChargeNotificationDelegate{
    
    //MARK: - Outlets -
    
    @IBOutlet weak var goalAmountLabel: UILabel!
    @IBOutlet weak var goalAmountMinusContributionLabel: UILabel!
    
    @IBOutlet weak var amountToContributeSlider: UISlider!
    
    @IBOutlet weak var amountToContributeLabel: UILabel!
    
    @IBOutlet weak var amountFundedLabel: UILabel!
    
    //MARK: - Properties -
    
    weak var delegate:StripeInformationDelegate?
    
    var partyItemToContributeTo:PartyItem?
    
    var eventToContributeTo = Event()
    
    var hostStripeUserID : String?
    
    var itemContribution = Int()
    
    //MARK: - View Cycle -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUp()
        
        setUpNavTitle()
        
    }
    
    
    //MARK: - General Setup -
    
    func setUp() -> Void {
        
        let unwrappedGoalAmount = (partyItemToContributeTo?.itemGoal)!
        goalAmountLabel.text = "PartyItem Goal: $\(unwrappedGoalAmount)"
        
        FirebaseManager.retrieveAmountFunded(partyItemName: (partyItemToContributeTo?.itemName)!,
                                             eventID: (partyItemToContributeTo?.eventID)!)
        { (partyItemAmountFunded) in
            
            self.partyItemToContributeTo?.itemAmountFunded = (partyItemAmountFunded as Double?)!
            
            let unwrappedFundedAmount = (self.partyItemToContributeTo?.itemAmountFunded)!
            self.amountFundedLabel.text = "$\(unwrappedFundedAmount) funded so far!"
            
            self.amountToContributeSlider.maximumValue = Float(((self.partyItemToContributeTo?.itemGoal)!-unwrappedFundedAmount))
            
        }

    }
    
    func setUpNavTitle() -> Void
    {
        
        let frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        let navLabel = UILabel(frame: frame)
        navLabel.font = UIFont(name: "Congratulations DEMO", size: 20.00)
        navLabel.textAlignment = .center
        navLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navLabel.text = partyItemToContributeTo?.itemName
        
        self.navigationItem.titleView = navLabel
    
        
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
            FirebaseManager.writeToFirebaseDBAmountFunded(partyItem: partyItemToContributeTo!)
            self.dismiss(animated: true, completion: nil)
        default:
            return
       
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)

        
    }
    
    //MARK: - Actions -
    
    @IBAction func contributionButtonPressed(_ sender: UIButton)
    {
        
        partyItemToContributeTo?.itemAmountFunded = Double(itemContribution) + (partyItemToContributeTo?.itemAmountFunded)!
        
        performSegue(withIdentifier: "goToPaymentVC", sender: self)

        
    }
    
    @IBAction func amountToContributeSlider(_ sender: UISlider)
    {
        itemContribution = Int(amountToContributeSlider.value)
        
        let partyItemGoal = Int((partyItemToContributeTo?.itemGoal)!)
        
        let newAmountFunded = Int((partyItemToContributeTo?.itemAmountFunded)!)
        
        amountToContributeLabel.text = "$\(itemContribution)"

        goalAmountMinusContributionLabel.text = "$\(partyItemGoal - newAmountFunded - itemContribution) left until goal is reached!"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "goToPaymentVC" {
            
            getHostStripeUserID()
            
            
            let navigation = segue.destination as! UINavigationController
            let newPaymentVC = navigation.topViewController as! PaymentViewController
            newPaymentVC.chargeNotificationDelegate = self
            self.delegate = newPaymentVC
            
        }
        
    }
    
    //MARK: - Stripe -

    func getHostStripeUserID()
    {
        
        FirebaseManager.retrieveHostStripeUserID(event:eventToContributeTo) { (returnedHostStripeUserID) -> () in
            
            self.hostStripeUserID = returnedHostStripeUserID
            
            self.delegate?.retrieveStripeID(stripeID: self.hostStripeUserID!)
            
            self.delegate?.retrieveAmount(amount: self.itemContribution)

        }
    }
    
}
