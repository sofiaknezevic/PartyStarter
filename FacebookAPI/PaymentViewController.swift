//
//  PaymentViewController.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-31.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import Stripe

class PaymentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPaymentVC()
        
        
    }
    
    func setUpPaymentVC() -> Void {
        
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: UIBarButtonItemStyle.plain,
                                           target: self,
                                           action: #selector(dismissSelf))
        
        self.navigationItem.leftBarButtonItem = cancelButton
        
    }

    func dismissSelf() -> Void {
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
