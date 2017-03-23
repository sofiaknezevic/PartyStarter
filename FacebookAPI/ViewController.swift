//
//  ViewController.swift
//  FacebookAPI
//
//  Created by Scott Hetland on 2017-03-22.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
//        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        AccessToken.current = nil
        
        if let accessToken = AccessToken.current {
            
            // User is logged in, use 'accessToken' here.
            performSegue(withIdentifier: "detailSegue", sender: self)
            print("this is the token: \(accessToken)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

