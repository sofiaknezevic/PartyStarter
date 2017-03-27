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
import FirebaseAuth


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    

    var id:String?
    var logButton : FBSDKLoginButton = FBSDKLoginButton()

    override func viewDidLoad() {
  

        
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
            performSegue(withIdentifier: "tableViewSegue", sender: self)
            print("this is the token: \(accessToken)")
            id = accessToken.userId
            print("this is user id: \(id!)")
            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //keep them on the same page
        print("logged out")
    }
    
    
    //this needs to be changed
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
       

        // User is logged in, use 'accessToken' here.
//        performSegue(withIdentifier: "tableViewSegue", sender: self)
//        print("next VC")

        print("User Logged In")
        
        
        self.logButton.isHidden = true
//        loadingSpinner.startAnimating()
        
        if(error != nil) {
            
            // handle errors here
            self.logButton.isHidden = false
//            loadingSpinner.stopAnimating()
            
        }
        else if (result.isCancelled) {
            //handle the cancel event
            self.logButton.isHidden = false
//            loadingSpinner.stopAnimating()
            
        }
            
        else  {
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                // ...
                
                //UserDefaults.standard.set(FIRAuth.auth()!.currentUser!.uid, forKey: "uid")
                
                //UserDefaults.standard.synchronize()
                print("User logged in to Firebase App!")
                
            }
            
        }
    }

}

