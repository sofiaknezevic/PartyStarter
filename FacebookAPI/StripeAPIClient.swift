//
//  StripeAPIClient.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import Stripe

class StripeAPIClient: NSObject{
    
    static let sharedClient = StripeAPIClient()
    let session: URLSession
    
    override init(){
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        self.session = URLSession(configuration: configuration)
        super.init()
        
    }
    
    func completeCharge(_ result:STPPaymentResult, userData:[String:Any], amount:Int, completion: @escaping STPErrorBlock)
    {
        
        
        
    }

    
}
