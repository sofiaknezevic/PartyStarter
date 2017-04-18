//
//  StripeConnectManager.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import Stripe
import FirebaseDatabase

class StripeConnectManager: NSObject {
    
    var currentJSON:[String:Any]?
    var clientSecretKey = String()
    
    var ref: FIRDatabaseReference!
    
    let connectURL = URL(string: "https://connect.stripe.com/oauth/token")
    

    
    func getClientSecretKey() -> Void {
        
        FirebaseManager.retrieveSecretKey { (secretKey) in
            
            self.clientSecretKey = secretKey
            
        }
        
    }
    
    
    func postToNetwork(code:String, completion:@escaping ([String:Any]) -> Void) -> Void  {
        
        let parameters: [String:String] = [
            "client_secret": self.clientSecretKey,
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
                    
                    completion(self.currentJSON!)
                    
                }
                
                // Write the whole stripe json to Firebase DB
                guard let stripeUserID = self.currentJSON?["stripe_user_id"] as? String else {
                    return
                }
                
                UserDefaults.standard.set(stripeUserID, forKey: "stripe_id")
                UserDefaults.standard.synchronize()
                                
                self.ref = FIRDatabase.database().reference()
                
                self.ref.child("stripe_json").child("\(stripeUserID)/").setValue(self.currentJSON)
            }
            
        }.resume()
    }

    
    
    //do we even need this method anymore? what is it even doing?

    // Read stripe JSON data from Firebase DB.
    func readStripeJSON() {
        
        ref = FIRDatabase.database().reference()
        

        self.ref.child("stripe_json").child((UserDefaults.standard.object(forKey: "uid") as? String!)!).queryOrderedByKey().queryLimited(toFirst: 1).observeSingleEvent(of: .value, with: { snapshot in
            
        
            
            if !snapshot.exists() {
                print("No snapshot exists")
                return
            }
            
            print("\(snapshot)")
            
            let enumerator = snapshot.children
            print("\(enumerator)")
            while (enumerator.nextObject() as? FIRDataSnapshot) != nil {
                for jsonData in snapshot.children.allObjects as! [FIRDataSnapshot] {
                    guard let restDict = jsonData.value as? [String: AnyObject] else {
                        continue
                    }
                    let getStripeUserID = restDict["stripe_user_id"]
                    print("PRINT STRIPE_USER_ID: ", getStripeUserID!)
                    
                }
            }
        })
    }
}
