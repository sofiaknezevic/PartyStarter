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
            
        }else{
            
            partyItemForContribution = attendingEvent?.partyItems?[indexPath.row]
            
            stripeConnectManager.readStripeJSON()
            
            self.prepareForContributionVC()
            
            
        }
        

        
    }
    
    func prepareForContributionVC() -> Void {
        
        let newContributeVC = ContributeToGoalViewController()
        newContributeVC.partyItemToContributeTo = partyItemForContribution
        newContributeVC.jsonOfHost = self.paymentReceiverJSON
        self.navigationController?.present(newContributeVC, animated: true, completion: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showEventDetail") {
            let detailVC:DetailViewController = segue.destination as! DetailViewController
            detailVC.detailEvent = attendingEvent
            
        }
        
    }

    
    func detailInformationButtonPushed() -> Void
    {
        performSegue(withIdentifier: "showEventDetail", sender: self)
        
    }


}
