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

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
