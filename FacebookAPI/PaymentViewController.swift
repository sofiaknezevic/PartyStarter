//
//  PaymentViewController.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-31.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import Stripe
import CreditCardForm


class PaymentViewController: UIViewController, StripeInformationDelegate{
    
    @IBOutlet weak var creditCardFormView: UIView!
    let paymentTextField = STPPaymentCardTextField()
    
    var connectedAccountID = String()
    let baseURLString = "http://localhost:4567/"
    
    let cardNumber = "4242424242424242"
    let expiryMonth = 9
    let expiryYear = 2020
    let cardCVC = "244"
    
    var cardJSON = [String:Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPaymentVC()
        
        
    }
    
    func retrieveStripeID(stripeID: String)
    {
        self.connectedAccountID = stripeID
        
    }
    

    
    func setUpPaymentVC() -> Void {
        
        paymentTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44)
        paymentTextField.translatesAutoresizingMaskIntoConstraints = false
        paymentTextField.borderWidth = 0
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: paymentTextField.frame.size.height - width, width:  paymentTextField.frame.size.width, height: paymentTextField.frame.size.height)
        border.borderWidth = width
        paymentTextField.layer.addSublayer(border)
        paymentTextField.layer.masksToBounds = true
        
        view.addSubview(paymentTextField)
        
        NSLayoutConstraint.activate([
            paymentTextField.topAnchor.constraint(equalTo: creditCardFormView.bottomAnchor, constant: 20),
            paymentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20),
            paymentTextField.heightAnchor.constraint(equalToConstant: 44)
            ])
        
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: UIBarButtonItemStyle.plain,
                                           target: self,
                                           action: #selector(dismissSelf))
        
        self.navigationItem.leftBarButtonItem = cancelButton
        
    }

    func dismissSelf() -> Void {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func getTokenButtonPushed(_ sender: UIButton)
    {
   
        getToken(cardNumber: cardNumber, expiryMonth: expiryMonth, expiryYear: expiryYear, cardCVC: cardCVC) { (cardDetails) in
            
            self.cardJSON = cardDetails
            
        }
        
    }
    
    @IBAction func chargeTokenButtonPushed(_ sender: UIButton)
    {
        chargeSourceCardToConnectedAccount(connectedAccountID: self.connectedAccountID, cardJSON: self.cardJSON) { (chargeJSON) in
            
            
        }
        
    }
    
    
    
    func getToken(cardNumber:String, expiryMonth:Int, expiryYear:Int, cardCVC:String, completion:@escaping ([String:Any]) -> Void) {
        
        let path = "create_token"
        let url = baseURLString.appending(path)
        let realURL = URL(string: url)
        
        let params:[String:AnyObject] = [
            "number" : cardNumber as AnyObject,
            "exp_month" : expiryMonth as AnyObject,
            "exp_year" : expiryYear as AnyObject,
            "cvc" : cardCVC as AnyObject
        ]
        
        let request = URLRequest.request(realURL!, method: .POST, params: params)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            self.cardJSON = try! JSONSerialization.jsonObject(with: data!, options:[]) as! [String:Any]
            print("\(self.cardJSON)")
            
            
            DispatchQueue.main.async {
                
                completion(self.cardJSON)
                
                
            }
            
            
        }
        
        task.resume()
        
        
    }

    func chargeSourceCardToConnectedAccount(connectedAccountID:String, cardJSON:[String:Any], completion:@escaping([String:Any]) -> Void) {
        
        let path = "charge_connected_account"
        let url = baseURLString.appending(path)
        let realURL = URL(string: url)
        
        let cardSource = cardJSON["id"] as! String
        
        let params:[String:AnyObject] = [
            "amount" : 1000 as AnyObject,
            "currency" : "cad" as AnyObject,
            "source" : cardSource as AnyObject,
            "stripe_account" : connectedAccountID as AnyObject
        ]
        
        let request = URLRequest.request(realURL!, method: .POST, params: params)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      
            
            let chargeJSON = try! JSONSerialization.jsonObject(with: data!, options:[])
            print("\(chargeJSON)")
            
            DispatchQueue.main.async {
                
                completion(chargeJSON as! [String : Any])
                
            }
            
        }
        
        task.resume()
        
    }

}
