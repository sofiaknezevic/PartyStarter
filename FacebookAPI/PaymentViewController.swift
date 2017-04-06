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
import PKHUD

protocol ChargeNotificationDelegate:class {
    
    func getAlert(notifier:Int)
    
}


class PaymentViewController: UIViewController, StripeInformationDelegate{
    
    @IBOutlet weak var creditCardFormView: UIView!
    
    @IBOutlet weak var contributionAmountLabel: UILabel!
    
    @IBOutlet weak var stripeFeeLabel: UILabel!
    
    @IBOutlet weak var grandTotalLabel: UILabel!
    
    let paymentTextField = STPPaymentCardTextField()
    
    weak var chargeNotificationDelegate:ChargeNotificationDelegate?
    
    
    var connectedAccountID = String()
    let baseURLString = "https://party-starter-app.herokuapp.com/"
    
    var cardNumber = String()
    var expiryMonth = UInt()
    var expiryYear = UInt()
    var cardCVC = String()
    
    var amount = Int()
    var stripeFee = Double()
    
    var cardJSON = [String:Any]()

    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
    }

    
    override func viewDidAppear(_ animated: Bool)
    {
        
        super.viewDidAppear(true)
        
        setUpPaymentVC()
        setUpLabels()
        
    }
    
    func retrieveStripeID(stripeID: String)
    {
        self.connectedAccountID = stripeID
        
    }
    
    func retrieveAmount(amount: Int)
    {
        
        self.amount = amount
        
        let doubleAmount = Double(amount)
        
        self.stripeFee = ((doubleAmount*0.029)+0.3)
        
    }

    
    func setUpPaymentVC() -> Void
    {
        
        
        creditCardFormView.layer.cornerRadius = creditCardFormView.layer.cornerRadius/2
        creditCardFormView.layer.masksToBounds = false
        
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
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: UIBarButtonItemStyle.done,
                                         target: self,
                                         action: #selector(setPaymentTextValues))
        
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: UIBarButtonItemStyle.plain,
                                           target: self,
                                           action: #selector(dismissSelf))
        
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = doneButton
        
        
        
    }

    func dismissSelf() -> Void
    {
        
        self.dismiss(animated: true, completion: nil)

    }
    
    func setUpLabels() -> Void
    {
        
        let newNumberFormatter = NumberFormatter()
        newNumberFormatter.numberStyle = .currency
        newNumberFormatter.locale = Locale(identifier: Locale.current.identifier)
        
        let totalAmount = Double(amount) + stripeFee
        
        let contributionString = newNumberFormatter.string(from: NSNumber(value: amount))
        let stripeFeeString = newNumberFormatter.string(from: NSNumber(value: stripeFee))
        let totalAmountString = newNumberFormatter.string(from: NSNumber(value: totalAmount))
        
        contributionAmountLabel.text = contributionString!
        stripeFeeLabel.text = stripeFeeString!
        grandTotalLabel.text = totalAmountString!
        
    }
    
    func setPaymentTextValues() -> Void
    {
        HUD.show(.progress)
        
        cardNumber = self.paymentTextField.cardNumber!
        cardCVC = self.paymentTextField.cvc!
        expiryYear = self.paymentTextField.expirationYear
        expiryMonth = self.paymentTextField.expirationMonth
        
        getToken(cardNumber: cardNumber,
                 expiryMonth: expiryMonth,
                 expiryYear: expiryYear,
                 cardCVC: cardCVC)
        { (cardDetails) in
            
            self.cardJSON = cardDetails
            
            self.chargeSourceCardToConnectedAccount(connectedAccountID: self.connectedAccountID,
                                                    cardJSON: self.cardJSON,
                                                    completion:
                { (chargeJSON) in
                
                if(chargeJSON["status"] as! String == "succeeded"){
                    
                    self.delay(1.0) {
                        // ...and once it finishes we flash the HUD for a second.
                        HUD.flash(.success, delay: 0.5)
                    }
                    
                    self.dismissSelf()
                    self.chargeNotificationDelegate?.getAlert(notifier: 1)
                    
                }else{
                    
                    self.delay(1.0) {
                        // ...and once it finishes we flash the HUD for a second.
                        HUD.flash(.success, delay: 0.5)
                    }
                    
                    self.chargeNotificationDelegate?.getAlert(notifier: 0)
                    
                    }
                
            })
            
        }
        
    }
    

    
    func getToken(cardNumber:String,
                  expiryMonth:UInt,
                  expiryYear:UInt,
                  cardCVC:String,
                  completion:@escaping ([String:Any]) -> Void)
    {
        
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
            
            
            DispatchQueue.main.async {
                
                completion(self.cardJSON)
                
                
            }
            
        }
        
        task.resume()
        
        
    }

    func chargeSourceCardToConnectedAccount(connectedAccountID:String,
                                            cardJSON:[String:Any],
                                            completion:@escaping([String:Any]) -> Void)
    {
        
        let path = "charge_connected_account"
        let url = baseURLString.appending(path)
        let realURL = URL(string: url)
        
        let cardSource = cardJSON["id"] as! String
        
        let realAmount = self.amount*100
        
        let params:[String:AnyObject] = [
            "amount" : realAmount as AnyObject,
            "currency" : "cad" as AnyObject,
            "source" : cardSource as AnyObject,
            "stripe_account" : connectedAccountID as AnyObject
        ]
        
        let request = URLRequest.request(realURL!, method: .POST, params: params)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      
            
            let chargeJSON = try! JSONSerialization.jsonObject(with: data!, options:[])
            
            DispatchQueue.main.async {
                
                completion(chargeJSON as! [String : Any])
                
            }
            
        }
        
        task.resume()
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.allButUpsideDown
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func delay(_ delay: Double, closure:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }

}
