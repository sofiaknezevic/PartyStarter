//
//  StripeAPIClient.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import Stripe

class StripeAPIClient: NSObject, STPBackendAPIAdapter{
    
    static let sharedClient = StripeAPIClient()
    let session: URLSession
    var baseURLString:String?
    
    override init(){
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        self.session = URLSession(configuration: configuration)
        super.init()
        
    }
    
    func completeCharge(_ result:STPPaymentResult, userData:[String:Any], amount:Int, completion: @escaping STPErrorBlock)
    {
        
        
        
    }
    
    func retrieveCustomer(_ completion: @escaping STPCustomerCompletionBlock)
    {
        
        
    }
    
    func attachSource(toCustomer source: STPSourceProtocol, completion: @escaping STPErrorBlock)
    {
        
        
    }

    
    func selectDefaultCustomerSource(_ source: STPSourceProtocol, completion: @escaping STPErrorBlock)
    {
        
        
    }
    
}
