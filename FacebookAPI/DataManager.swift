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
                    
                    let newEvent = Event.parseDataForTableViewFromJSON(event)
                    
                    //need to append this new event into an array that we can pass to table view controller
//                    DataManager().eventArray?.append(newEvent)
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
    
    class func getEventDetails(eventID: String, completion:@escaping (Event) -> ()) {
        
        //need to pass in the event ID, use fake id 2
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/\(eventID)")) { httpResponse, result in
            
            switch result {
            case .success(let response):
                let data = response.dictionaryValue!
                
                let selectedEvent = Event.parseDataFromJSON(data)
                
                print(selectedEvent.eventName!)
            
            completion(selectedEvent)
            
            case .failed(let error):
                print("Graph Request Failed: \(error)")
        }
        }
        connection.start()
    }
}
