//
//  DetailViewController.swift
//  FacebookAPI
//
//  Created by Scott Hetland on 2017-03-22.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import FacebookCore
import MapKit

class DetailViewController: UIViewController {
    
    var detailEvent:Event?
    
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var eventIDLabel: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    @IBOutlet weak var rsvpStatusLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var attendeesLabel: UILabel!
    @IBOutlet weak var adminsLabel: UILabel!
    
    @IBOutlet weak var detailStartTimeLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailEventNameLabel: UILabel!
    @IBOutlet weak var detailLocationLabel: UILabel!
    @IBOutlet weak var detailTextField: UITextView!
    @IBOutlet weak var detailrsvpLabel: UILabel!
    @IBOutlet weak var navigationButtonOutlet: UIButton!
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationButtonOutlet.isHidden = true
        
        //download image and set it to the imageview
        DataManager.getEventImage(eventID: (detailEvent?.eventID)!) { image in
            
            DispatchQueue.main.async {
                self.detailEvent?.coverPhoto = image.photo
                
                self.detailImageView.image = self.detailEvent?.coverPhoto
                self.detailImageView.layer.borderColor = #colorLiteral(red: 0.9764705882, green: 0.9803921569, blue: 0.7882352941, alpha: 1).cgColor
                self.detailImageView.layer.borderWidth = 4
                self.detailImageView.layer.cornerRadius = 4
                self.detailImageView.layer.masksToBounds = true
                self.navigationButtonOutlet.isHidden = false
            }

        }
        
        navigationButtonOutlet.layer.cornerRadius = 10
        navigationButtonOutlet.clipsToBounds = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setup()

    }
    
    
    func setup() -> Void {

        let unwrappedRSVP = (detailEvent?.rsvpStatus)! as String
        
        detailEventNameLabel.text = detailEvent?.eventName
        detailLocationLabel.text = detailEvent?.placeName
        detailDescriptionLabel.text = detailEvent?.eventDescription
        detailrsvpLabel.text = "RSVP Status: \(unwrappedRSVP)"
        
        if let startTime = detailEvent?.startTime {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        let date = dateFormatter.date(from: startTime)
        dateFormatter.dateFormat = "HH:mm eee MMM dd yyyy"
        let dateStr = dateFormatter.string(from: date!)
        
        detailStartTimeLabel.text = "Start Time: \(dateStr)"
        }
        
    }
    
    @IBAction func mapToEvent(_ sender: UIButton) {
        //when this button is pressed you need to check whether or not the event has valid coordinates. If so then map them
        if (detailEvent?.latitute != nil) {
            //do the stuff
            print("has coordinates")
            
            
            let pinCoordinates = CLLocationCoordinate2D.init(latitude: (detailEvent?.latitute)!, longitude: (detailEvent?.longitude)!)
            let placeMark = MKPlacemark.init(coordinate: pinCoordinates)
            let mapItem = MKMapItem.init(placemark: placeMark)
            
            mapItem.name = detailEvent?.eventName
            mapItem.openInMaps(launchOptions: nil)
    
        } else {
            
            self.navigationButtonOutlet.setTitle("Not Available", for: .normal)
            print("no coordinates")
        }
    }
    
}
