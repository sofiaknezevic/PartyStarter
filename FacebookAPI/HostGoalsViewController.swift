//
//  HostGoalsViewController.swift
//  FacebookAPI
//
//  Created by Sofia Knezevic on 2017-03-27.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class HostGoalsViewController: UIViewController {
    
    //pass forward the information from the selected event. Will use some info and pass forward to detail view controller
    var hostEvent:Event?
    var hostUser:User?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpAttendingGoalsVCWith(event: hostEvent!)

    }
    
    func setUpAttendingGoalsVCWith(event:Event) -> Void {
        
        self.navigationItem.title = event.eventName
        let detailInfoButton = UIBarButtonItem(image: #imageLiteral(resourceName: "infoVector"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(detailInformationButtonPushed))
        
        self.navigationItem.rightBarButtonItem = detailInfoButton
        
        
    }

    @IBAction func addNewItem(_ sender: UIButton) {
        
        //when this button is pressed segue to the addNewItem view controller
        performSegue(withIdentifier: "addNewItem", sender: self)
        
        
    }

    
    @IBAction func connectToStripePushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "connectToStripe", sender: self)
        
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
    }
    
    func detailInformationButtonPushed() -> Void
    {
        performSegue(withIdentifier: "showEventDetail", sender: self)
        
    }
}
