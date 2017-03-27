//
//  DetailViewController.swift
//  FacebookAPI
//
//  Created by Scott Hetland on 2017-03-22.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import FacebookCore

class DetailViewController: UIViewController {
    
    var detailEvent:Event?
    
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var eventIDLabel: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var rsvpStatusLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var attendeesLabel: UILabel!
    @IBOutlet weak var adminsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setup()
        
        print("this are the admins: \(detailEvent?.admins)")
        print("this are the attendees: \(detailEvent?.attendees)")

    }
    
    
    func setup() -> Void {
        //set the labels equal to what you pass in
        eventDescriptionLabel.text = detailEvent?.eventDescription
        eventNameLabel.text = detailEvent?.eventName
        placeNameLabel.text = detailEvent?.placeName
        
        let eventID = detailEvent?.eventID
        eventIDLabel.text = "Event ID: \(eventID!)"
        
        let rsvpStatus = detailEvent?.rsvpStatus
        rsvpStatusLabel.text = "RSVP Status: \(rsvpStatus!)"
        
        //need to convert this to a readable date
        let startTime = detailEvent?.startTime
        startTimeLabel.text = "Start time: \(startTime!)"
        
        let endTime = detailEvent?.endTime
        endTimeLabel.text = "End time: \(endTime!)"
        
        //will this crash if any are nil? Need to do safe unwrap
        let street = detailEvent?.street ?? ""
        let cityName = detailEvent?.cityName ?? ""
        let state = detailEvent?.state ?? ""
        let zipCode = detailEvent?.zipCode ?? ""
        addresslabel.text = "\(street), \(cityName) \(state), \(zipCode)"
        
        print(addresslabel.text!)
        
        //how to get this to work?
        eventImageView.image = detailEvent?.coverPhoto
        
        //want to show who the name of the attendees for the event
        attendeesLabel.text = detailEvent?.attendees?.description
        adminsLabel.text = detailEvent?.admins?.description
        
        //if your user id is in the array of admins, then there needs to be something to tell you that you are the hose
        
        
    }
}
