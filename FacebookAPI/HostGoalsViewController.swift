//
//  HostGoalsViewController.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class HostGoalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //pass forward the information from the selected event. Will use some info and pass forward to detail view controller
    var hostEvent = Event()
    var hostUser = User()
    var numberOfPartyItemsArray = [PartyItem]()
    @IBOutlet weak var hostGoalsTableView: UITableView!
    
    var segueIdentifier:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "GoalsTableViewCell", bundle: nil)
        
        hostGoalsTableView.register(nib, forCellReuseIdentifier: "GoalsCell")
        
        setUpHostGoalsVCWith(event: hostEvent)
        
        setUpInfoButton()
        
        FirebaseManager.retrievePartyItemsFromFirebase(eventID: hostEvent.eventID!) { (partyItemNameArray) -> () in
            
            self.numberOfPartyItemsArray = partyItemNameArray
            self.hostGoalsTableView.reloadData()
        }
        
        //check to see if they have a stripe account associated with them. If not then segue to the connectToStripe VC

    }
    
    func setUpHostGoalsVCWith(event:Event) -> Void {
        
        let frame = CGRect(x: 0, y: 0, width: 400, height: 44)
        let navLabel = UILabel(frame: frame)
        navLabel.font = UIFont.systemFont(ofSize: 20.0, weight: UIFontWeightUltraLight)
        navLabel.textAlignment = .center
        //I want to change this text color later, but its not really letting me right now
        navLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navLabel.text = event.eventName
        
        self.navigationItem.titleView = navLabel
        
    }
    
    func setUpInfoButton() -> Void {
        
        let detailInfoButton = UIBarButtonItem(image: #imageLiteral(resourceName: "betterInfoVector"),
                                               style: UIBarButtonItemStyle.plain,
                                               target: self, action: #selector(detailInformationButtonPushed))
        
        self.navigationItem.rightBarButtonItem = detailInfoButton
        
        
    }

    @IBAction func addNewItem(_ sender: UIButton) {
        
        //when this button is pressed segue to the addNewItem view controller
        //first check if they have a stripe account hooked up and if they don't, send them to stripe and make them connect
        checkEventStripeID()
        performSegue(withIdentifier: segueIdentifier!, sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showEventDetail") {
            let detailVC:DetailViewController = segue.destination as! DetailViewController
            detailVC.detailEvent = hostEvent
            
        }
        
        if (segue.identifier == "addNewItem") {
            
            //need to pass at the event item so that you can get access to the event name and eventID
            let addNewItemVC:AddNewItemViewController = segue.destination as! AddNewItemViewController
            addNewItemVC.eventToAddItemTo = hostEvent
            addNewItemVC.addNewItemHost = hostUser
        }
        
        if segue.identifier == "connectToStripe" {
            
         
            let navigation = segue.destination as! UINavigationController
            let connectToStripeVC = navigation.topViewController as! ConnectToStripeViewController
            connectToStripeVC.stripeEvent = hostEvent
            
        }
    }
    
    func checkEventStripeID() -> Void
    {
        if hostEvent.stripeID != "" {
            
            segueIdentifier = "addNewItem"
            
        }else{
            
            segueIdentifier = "connectToStripe"
            
        }
        
    }
    
    func detailInformationButtonPushed() -> Void
    {
        performSegue(withIdentifier: "showEventDetail", sender: self)
        
    }
    
    //MARK: Table View Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.numberOfPartyItemsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalsCell", for: indexPath) as! GoalsTableViewCell

        cell.configureCellWithPartyItem(partyItem: self.numberOfPartyItemsArray[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if (editingStyle == UITableViewCellEditingStyle.delete) {

            if self.numberOfPartyItemsArray.count > 0 {
                
                self.numberOfPartyItemsArray.remove(at: indexPath.row)
                hostGoalsTableView.reloadData()
                
                // ***** Need to add a line that removes the party item from Firebase DB *****
            } else {
                hostGoalsTableView.endUpdates()
            }
        }
    }
}
