//
//  AttendingGoalsViewController.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class AttendingGoalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //information for the event that the user is attending
    var attendingEvent = Event()
    var attendingUser = User()

    @IBOutlet weak var attendingTableView: UITableView!
    

    var partyItemForContribution:PartyItem?
    
    var paymentReceiverJSON:[String:Any]?
    
    let stripeConnectManager = StripeConnectManager()


    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "GoalsTableViewCell", bundle: nil)
        
        attendingTableView.register(nib, forCellReuseIdentifier: "GoalsCell")
        
        setUpAttendingGoalsVCWith(event: attendingEvent)
        
        setUpDetailInfoButton()
        
        //take this out before demo day... this is all fake shtuff
        setUpFakePartyItemForTesting(event: attendingEvent)
    }

    
    //should refactor a little bit I think because having the same thing for two VC'S isn't very "DRY"....
    func setUpAttendingGoalsVCWith(event:Event) -> Void {
        
        let frame = CGRect(x: 0, y: 0, width: 400, height: 44)
        let navLabel = UILabel(frame: frame)
        navLabel.font = UIFont.systemFont(ofSize: 20.0, weight: UIFontWeightLight)
        navLabel.textAlignment = .center
        //I want to change this text color later, but its not really letting me right now
        navLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navLabel.text = event.eventName
        
        self.navigationItem.titleView = navLabel
        
    }
    
    func setUpDetailInfoButton() -> Void
    {
        let detailInfoButton = UIBarButtonItem(image: #imageLiteral(resourceName: "betterInfoVector"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(detailInformationButtonPushed))
        
        self.navigationItem.rightBarButtonItem = detailInfoButton
        
        
    }
    
    func setUpFakePartyItemForTesting(event:Event) -> Void {
        
        let newPartyItem = PartyItem(name: "balloons",
                                     goal: 150.00,
                                     image:#imageLiteral(resourceName: "choosePartyImage"),
                                     itemEventID: event.eventID!)
        
        let newPartyItem2 = PartyItem(name: "tables",
                                     goal: 200.00,
                                     image:#imageLiteral(resourceName: "choosePartyImage"),
                                     itemEventID: event.eventID!)
        
        event.partyItems.append(newPartyItem)
        event.partyItems.append(newPartyItem2)
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if attendingEvent.partyItems.count == 0 {
            
            return 1
            
        }
        
        return (attendingEvent.partyItems.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalsCell", for: indexPath) as! GoalsTableViewCell
        cell.configureCellWith(event: attendingEvent, indexPath:indexPath.row)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        if attendingEvent.partyItems.count == 0 {
         
            tableView.deselectRow(at: indexPath, animated: true)
            
        }else{
            
            partyItemForContribution = attendingEvent.partyItems[indexPath.row]
            
            //stripeConnectManager.readStripeJSON()
        
            performSegue(withIdentifier: "showContributeToGoalVC", sender: self)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showEventDetail") {
            let detailVC:DetailViewController = segue.destination as! DetailViewController
            detailVC.detailEvent = attendingEvent
            
        }
        
        if (segue.identifier == "showContributeToGoalVC") {
            
            let newContributeVC:ContributeToGoalViewController = segue.destination as! ContributeToGoalViewController
            
            //send over the json as well here!!!!!!!!!
            //newContributeVC.jsonOfHost = self.paymentReceiverJSON
            newContributeVC.partyItemToContributeTo = partyItemForContribution
            
        }
        
    }

    
    func detailInformationButtonPushed() -> Void
    {
        performSegue(withIdentifier: "showEventDetail", sender: self)
        
    }


}
