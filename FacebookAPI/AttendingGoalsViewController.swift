//
//  AttendingGoalsViewController.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class AttendingGoalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //information for the event that the user is attending
    var attendingEvent:Event?

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "attendingGoalsCell", for: indexPath) as! AttendingGoalsTableViewCell
        cell.configureCellWith(event: attendingEvent!, indexPath:indexPath.row)
        return cell
        
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
