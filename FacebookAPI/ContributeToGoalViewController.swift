//
//  ContributeToGoalViewController.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-28.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import Stripe

class ContributeToGoalViewController: UIViewController, STPPaymentContextDelegate {
    
    let backendBaseURL: String? = "http://localhost:4567/"
    
    var paymentContext:STPPaymentContext?
    let paymentCurrency = "CAD"
    var jsonOfContributor:[String:Any]?
    
    var partyItemToContributeTo:PartyItem?

    @IBOutlet weak var paymentAmountSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init(jsonCustomerInformation:[String:Any])
    {
        StripeAPIClient.sharedClient.baseURLString = backendBaseURL
        
        let stripePublishableKey = jsonCustomerInformation["stripe_publishable_key"] as! String
        
        let paymentConfiguration = STPPaymentConfiguration.shared()
        
        paymentConfiguration.publishableKey = stripePublishableKey
        
        let userInformation = STPUserInformation()
        
        let paymentContext = STPPaymentContext(apiAdapter: StripeAPIClient.sharedClient,
                                               configuration: paymentConfiguration,
                                               theme: STPTheme.default())
        
        paymentContext.prefilledInformation = userInformation
        
        paymentContext.paymentAmount = 5000
        
        paymentContext.paymentCurrency = self.paymentCurrency
        
        self.paymentContext = paymentContext

        super.init(nibName: "ContributeToGoalView", bundle: nil)
        
        self.paymentContext?.hostViewController = self
        
        self.jsonOfContributor = jsonCustomerInformation
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    



    func paymentContextDidChange(_ paymentContext: STPPaymentContext)
    {
    
        self.paymentContext = paymentContext
        
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock)
    {
        
        StripeAPIClient.sharedClient.completeCharge(paymentResult, userData:self.jsonOfContributor!, amount: (self.paymentContext?.paymentAmount)!, completion: completion)
        
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?)
    {
        
        let title: String
        let message: String
        switch status {
        case .error:
            title = "Error"
            message = error?.localizedDescription ?? ""
        case .success:
            title = "Success"
            message = "You paid $50 randomly to nothing 🙃"
        case .userCancellation:
            return
            
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error)
    {
        
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
            _ = self.navigationController?.popViewController(animated: true)
            
        }
        
        let retry = UIAlertAction(title: "Retry", style: .default) { action in
            
            self.paymentContext?.retryLoading()
        }
        
        alertController.addAction(cancel)
        alertController.addAction(retry)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func payButtonPressed(_ sender: UIButton)
    {
        
        
        self.paymentContext?.requestPayment()
        
        
    }


}
