//
//  StripeConnectManager.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import Stripe

class StripeConnectManager: NSObject {
    
    var currentJSON:Dictionary<String, Any> = [:]
    
    let connectURL = URL(string: "https://connect.stripe.com/oauth/token")
    
    
    func postToNetwork(code:String, completion:@escaping ([String:Any]) -> Void) -> Void  {
        
        let parameters: [String:String] = [
            "client_secret":"sk_test_Jjjc1jknwZWhIyW9OlBRA6eK",
            "code":code,
            "grant_type":"authorization_code"
            
        ]
        
        let request = URLRequest.request(connectURL!, method: .POST, params: parameters as [String : AnyObject])
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                
                print("\(error)")
                
            }else{
                
                let newJSON = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                self.currentJSON = newJSON!
                print("\(self.currentJSON)")
                
                DispatchQueue.main.async {
                    
                    completion(self.currentJSON)
                    
                }
                
                
            }
            
            }.resume()
        
    }

}
