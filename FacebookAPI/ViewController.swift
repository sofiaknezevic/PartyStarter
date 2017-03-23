//
//  ViewController.swift
//  FacebookAPI
//
//  Created by Scott Hetland on 2017-03-22.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookCore
import FacebookLogin


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    

    var id:String?
    
    override func viewDidLoad() {
  
        let logButton : FBSDKLoginButton = FBSDKLoginButton()
        
        logButton.readPermissions = ["email", "public_profile", "user_friends", "user_events"]

        logButton.center = view.center
        
        logButton.delegate = self
        
        view.addSubview(logButton)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
//        AccessToken.current = nil
        
        if let accessToken = AccessToken.current {
            
            // User is logged in, use 'accessToken' here.
            performSegue(withIdentifier: "detailSegue", sender: self)
            print("this is the token: \(accessToken)")
            id = accessToken.userId
            print("this is user id: \(id!)")
            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //keep them on the same page
        print("logged out")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
       
            // User is logged in, use 'accessToken' here.
            performSegue(withIdentifier: "detailSegue", sender: self)
            print("next VC")

}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            //pass on the userID to the next screen
        }
    }
}

