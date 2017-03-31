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
    var hostEvent:Event?
    var hostUser:User?
    @IBOutlet weak var hostGoalsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "GoalsTableViewCell", bundle: nil)
        
        hostGoalsTableView.register(nib, forCellReuseIdentifier: "GoalsCell")
        
        setUpHostGoalsVCWith(event: hostEvent!)
        
        //check to see if they have a stripe account associated with them. If not then segue to the connectToStripe VC

    }
    
    func setUpHostGoalsVCWith(event:Event) -> Void {
        
        self.navigationItem.title = event.eventName
        let detailInfoButton = UIBarButtonItem(image: #imageLiteral(resourceName: "betterInfoVector"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(detailInformationButtonPushed))
        
        self.navigationItem.rightBarButtonItem = detailInfoButton
        
        
    }

    @IBAction func addNewItem(_ sender: UIButton) {
        
        //when this button is pressed segue to the addNewItem view controller
        //first check if they have a stripe account hooked up and if they don't, send them to stripe and make them connect 
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
    
    //MARK: Table View Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hostEvent?.partyItems.count == nil || hostEvent?.partyItems.count == 0 {
            
            return 1
            
        }
        
        return (hostEvent?.partyItems.count)!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalsCell", for: indexPath) as! GoalsTableViewCell
        cell.configureCellWith(event: hostEvent!, indexPath:indexPath.row)
        return cell
        
    }
    

}
