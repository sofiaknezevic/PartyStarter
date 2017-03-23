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
    
    var eventArray:Array<Any>?
        
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
    
    class func getEvents(completion:@escaping (Event)->()) {
        
        let currentDateInSeconds = Int(Date().timeIntervalSince1970)
        
        //print((int)currentDateInSeconds)
        
        //1417508443
                
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me/events?since=\(currentDateInSeconds)")) { httpResponse, result in
        
            switch result {
            case .success(let response):
                
                let data = response.dictionaryValue?["data"] as? [[String: Any]]
                
                //this works, printing it out
//                print(data!)
                
                //need to get the index of the event 
                for event: [String: Any] in data! {
                    
                    let newEvent = Event.parseDataFromJSON(event)
                    
                    DataManager().eventArray?.append(newEvent)
                    print(newEvent.eventName!)
                    
                }
                
//                let arrayOfEvents = DataManager().eventArray
                
//                print("this is the first item in the array: \(arrayOfEvents?.first)")
                
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
        }
        connection.start()
}
}



