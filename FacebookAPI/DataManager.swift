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
        var parameters: [String: Any]? = ["fields": "id, name"]

        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me")) { httpResponse, result in
            
            switch result {
            case .success(let response):
                user.name = response.dictionaryValue?["id"] as? String
                user.userID = response.dictionaryValue?["name"] as? String
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
                
                //make new events from every event in the json
                for event: [String: Any] in data! {
                    
                    let newEvent = Event.parseDataFromJSON(event)
                    
                    eventArray.append(newEvent)
                   
                }
                print("data manager: \(eventArray)")
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
                    
                    print("admins: \(newAdmin.adminName!)")
                    
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
                    
                    print("attending: \(newAttendee.attendeeName!)")
                    
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
    //doesn't go to the success result even when I put other graphPaths in there.
    class func getEventImage(eventID: String, completion:@escaping (CoverPhoto)->()) {
        

        let coverPhoto = CoverPhoto()
        
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/\(eventID)/picture")) { httpResponse, result in
            
            switch result {
            case .success(let response):
                
                
                let data = response.dictionaryValue?["data"] as? [String: Any]
                
                print(data!)
                
                coverPhoto.photoURL = data?["url"] as? String
                
                let url = URL(string: coverPhoto.photoURL!)
                
                //then call the downloader task, have it return an image
                let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
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
                
            case .failed(let error):
            print("Graph Request Failed: \(error)")
            }
        }
        connection.start()
        
}
}
