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
    

    override func viewDidLoad() {
  
        //going to need to add this: 
        //let logButton = FBSDKLoginButton(readPermissions: [ .publicProfile, .Email, .UserFriends ])

        let logButton : FBSDKLoginButton = FBSDKLoginButton()

        logButton.center = view.center
        
        logButton.delegate = self
        
        view.addSubview(logButton)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if let accessToken = AccessToken.current {
            
            // User is logged in, use 'accessToken' here.
            performSegue(withIdentifier: "detailSegue", sender: self)
            print("this is the token: \(accessToken)")
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
}

