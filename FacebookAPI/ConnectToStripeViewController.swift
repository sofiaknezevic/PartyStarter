//
//  ConnectToStripeViewController.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

protocol GoToAddItemDelegate:class {
    
    func retrieveNotifier(notifier:Int)
    
}

class ConnectToStripeViewController: UIViewController, ServerInformationDelegate {
    
    weak var addItemDelegate:GoToAddItemDelegate?

    var connectedAccountJSON:[String:Any]?
    
    var stripeEvent = Event()

    override func viewDidLoad() {
   
        super.viewDidLoad()
        
    }

    @IBAction func connectToStripePushed(_ sender: UIButton)
    {
        
        performSegue(withIdentifier: "authorizeStripe", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "authorizeStripe" {
            
            let newAuthorizationVC:StripeAuthorizationViewController = segue.destination as! StripeAuthorizationViewController
            newAuthorizationVC.delegate = self
        }
        
    }
    
    func retrieveJSON(newCustomerJSON: [String : Any])
    {
        
        self.connectedAccountJSON = newCustomerJSON

        stripeEvent.stripeID = self.connectedAccountJSON?["stripe_user_id"] as! String

        FirebaseManager.writeToFirebaseDBHostStripeUserID(eventID: stripeEvent.eventID!)
    
        self.presentedViewController?.dismiss(animated: true, completion: { 
            
            
            self.dismiss(animated: true, completion: nil)
            
            self.addItemDelegate?.retrieveNotifier(notifier: 1)
            
        })

    }
    
    

}
