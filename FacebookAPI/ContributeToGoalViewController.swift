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
    
    var paymentContext: STPPaymentContext
    let paymentCurrency = "CAD"
    var jsonOfContributor:[String:Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init(jsonCustomerInformation:[String:Any])
    {
        
        let stripePublishableKey = jsonCustomerInformation[""] as! String
        
        let paymentConfiguration = STPPaymentConfiguration.shared()
        
        paymentConfiguration.publishableKey = stripePublishableKey
        
        let paymentContext = STPPaymentContext(apiAdapter: StripeAPIClient.sharedClient,
                                               configuration: paymentConfiguration,
                                               theme: STPTheme.default())
        self.paymentContext = paymentContext
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func paymentContextDidChange(_ paymentContext: STPPaymentContext)
    {
        
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock)
    {
        
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?)
    {
        
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error)
    {
        
        
    }
    


}
