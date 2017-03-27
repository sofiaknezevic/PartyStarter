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
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var eventIDLabel: UILabel!
    @IBOutlet weak var placeIDLabel: UILabel!
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
        eventIDLabel.text = detailEvent?.eventID
        eventImageView.image = detailEvent?.coverPhoto
        
        //want to show who the name of the attendees for the event
        attendeesLabel.text = detailEvent?.attendees?.description
        
        
    }
}
