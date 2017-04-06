//
//  DataManager.swift
//  FacebookAPI
//
//  Created by Scott Hetland on 2017-03-23.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit
import FacebookCore


class DataManager: NSObject {
    
    
    class func getUserInfo(completion:@escaping (User)->()) {
        
        let user = User()
        
        //what are we using this for? do we need this?
        //var parameters: [String: Any]? = ["fields": "id, name"]

        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me")) { httpResponse, result in
            
            switch result {
            case .success(let response):
                user.userID = response.dictionaryValue?["id"] as? String
                user.name = response.dictionaryValue?["name"] as? String
                completion(user)
                
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
        }
        connection.start()
    }
    //this gets the events for the table view cell
    class func getEvents(completion:@escaping ([Event])->()) {
        
        var eventArray = [Event]()
        
        let currentDateInSeconds = Int(Date().timeIntervalSince1970)
        
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me/events?since=\(currentDateInSeconds)")) { httpResponse, result in
        
            switch result {
            case .success(let response):
                
                let data = response.dictionaryValue?["data"] as? [[String: Any]]
                
                for event: [String: Any] in data! {
                    
                    let newEvent = Event.parseDataFromJSON(event)
                    
                    eventArray.append(newEvent)
                   
                }
                completion(eventArray)
                
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
        }
        connection.start()

    }
    
    //admins - array of admins, pass in eventID
    class func getEventAdmins(eventID: String, completion:@escaping ([Admins]) -> ()) {
        
        var adminArray = [Admins]()
        
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "\(eventID)/admins")) { httpResponse, result in
            
            switch result {
            case .success(let response):
                
                let data = response.dictionaryValue?["data"] as? [[String: Any]]
                
                for admin: [String: Any] in data! {
                    
                    let newAdmin = Admins.parseAdminsFromJSON(admin)
                    
                    newAdmin.adminEventID = eventID
                    
                    adminArray.append(newAdmin)
    
                }
                completion(adminArray)
        
            case .failed(let error):
                print("Graph Request Failed: \(error)")

            }
        }
        connection.start()
        
    }
    
    
    //attending - array of attendees, pass in eventID
    class func getEventAttendees(eventID: String, completion:@escaping ([Attendees]) -> ()) {
    
        var attendeeArray = [Attendees]()
    
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "\(eventID)/attending")) { httpResponse, result in
            
            switch result {
            case .success(let response):
                
                let data = response.dictionaryValue?["data"] as? [[String: Any]]
                
                for attendee: [String: Any] in data! {
                    
                    let newAttendee = Attendees.parseAttendeesFromJSON(attendee)
                    
                    attendeeArray.append(newAttendee)
                }
                completion(attendeeArray)
                
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
        }
        connection.start()
        
    }
    
    
    //picture
    class func getEventImage(eventID: String, completion:@escaping (CoverPhoto)->()) {
        
        //not doing this the 100% correct way that facebook wants us to
        let coverPhoto = CoverPhoto()
        let parameters: [String: Any]? = ["fields": "data"]

        var request = GraphRequest(graphPath: "/\(eventID)/picture?type=large")
        request.parameters = parameters
        
        let connection = GraphRequestConnection()
        connection.add(request) { httpResponse, result in
            
            if let url = httpResponse?.url {
                coverPhoto.photoURL = url
                
                //then call the downloader task, have it return an image
                let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    if error != nil {
                        print("error found")
                    } else {
                        do {
                            let image = UIImage(data: data!)
                            
                            coverPhoto.photo = image
                            
                            completion(coverPhoto)
                        }
                    }
                })
                task.resume()
            }
            
        }
        connection.start()
        
}
}
