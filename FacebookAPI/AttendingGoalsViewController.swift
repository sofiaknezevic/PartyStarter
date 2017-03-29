//
//  AttendingGoalsViewController.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class AttendingGoalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ServerInformationDelegate {
    
    //information for the event that the user is attending
    var attendingEvent:Event?

    @IBOutlet weak var attendingTableView: UITableView!
    

    var partyItemForContribution:PartyItem?
    
    var paymentReceiverJSON:[String:Any]?
    
    let stripeConnectManager = StripeConnectManager()


    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "GoalsTableViewCell", bundle: nil)
        
        attendingTableView.register(nib, forCellReuseIdentifier: "GoalsCell")
        
        setUpAttendingGoalsVCWith(event: attendingEvent!)
    }

    func setUpAttendingGoalsVCWith(event:Event) -> Void {
        
        self.navigationItem.title = event.eventName
        let detailInfoButton = UIBarButtonItem(image: #imageLiteral(resourceName: "infoVector"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(detailInformationButtonPushed))
        
        self.navigationItem.rightBarButtonItem = detailInfoButton
        
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if attendingEvent?.partyItems?.count == nil || attendingEvent?.partyItems?.count == 0 {
            
            return 1
            
        }
        
        return (attendingEvent?.partyItems!.count)!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalsCell", for: indexPath) as! GoalsTableViewCell
        cell.configureCellWith(event: attendingEvent!, indexPath:indexPath.row)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        if attendingEvent?.partyItems?.count == nil || attendingEvent?.partyItems?.count == 0 {
         
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
        
        partyItemForContribution = attendingEvent?.partyItems?[indexPath.row]
        let newContributeVC = ContributeToGoalViewController(jsonHostInformation: self.paymentReceiverJSON!)
        newContributeVC.partyItemToContributeTo = partyItemForContribution
        self.navigationController?.present(newContributeVC, animated: true, completion: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showEventDetail") {
            let detailVC:DetailViewController = segue.destination as! DetailViewController
            detailVC.detailEvent = attendingEvent
            
        }
        
    }
    
    func retrieveJSON(newCustomerJSON: [String : Any])
    {
        self.paymentReceiverJSON = newCustomerJSON
        
        performSegue(withIdentifier: "contributeToGoals", sender: self)
        
    }
    
    func detailInformationButtonPushed() -> Void
    {
        performSegue(withIdentifier: "showEventDetail", sender: self)
        
    }


}
