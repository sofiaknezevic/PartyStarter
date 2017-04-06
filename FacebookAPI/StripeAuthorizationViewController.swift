//
//  StripeAuthorizationViewController.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import Stripe

protocol ServerInformationDelegate:class {
    
    func retrieveJSON(newCustomerJSON:[String:Any])
    
}

class StripeAuthorizationViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var stripeWebView: UIWebView!
    
    weak var delegate:ServerInformationDelegate?
    
    let requestForStripeConnect = StripeConnectManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let authURL = URL(string: "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_AKvPJVtMwPNyOtjb04bHnsxiQUCamFqV&scope=read_write")
        
        stripeWebView.loadRequest(URLRequest(url: authURL!))
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        stripeWebView.delegate = self
        
        super.viewWillAppear(true)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let url = request.url else{
            
            return true
            
        }
        
        guard url.host == "www.sofia.com" else{
            
            return true
            
        }
        
        var authorizationToken = url.absoluteString.components(separatedBy: "code=")
        
        if authorizationToken[1].hasPrefix("ac_") {
            
            
            requestForStripeConnect.postToNetwork(code: authorizationToken[1])
            { response in
                
                self.delegate?.retrieveJSON(newCustomerJSON: self.requestForStripeConnect.currentJSON!)
                
                
            }
        }
        
        
        return true
        
    }


}
