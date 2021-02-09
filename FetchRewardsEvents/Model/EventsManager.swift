//
//  EventsManager.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/3/21.
//

import Foundation

struct EventsManager {
    
    //Client Id should be stored somewhere else, can't be exposed directly
    
    func fetchEvents(page: Int, completionHandler: @escaping (([EventsInfo]) -> Void)) {
        let eventsURL = "https://api.seatgeek.com/2/events?client_id=MjE1MjU4NDV8MTYxMjM3Njk0Ny42NjU5Nzc3"
        let urlString = "\(eventsURL)&per_page=10&page=\(page)"
        //Create a URL Object
        
        if let url = URL(string: urlString) {
            //Create a URL Session
            let session = URLSession(configuration: .default)
            //Giving session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let eventsData = self.parseJSON(eventsData: safeData) {
                        completionHandler(eventsData)
                    }
                }
            }
            task.resume()
        }
        
        
    }
    
    func parseJSON(eventsData: Data) -> [EventsInfo]? {
        let decoder = JSONDecoder()
        do {
            let eventsDecodedData = try decoder.decode(EventsInfoResponse.self, from: eventsData)
            return eventsDecodedData.events
        }
        catch {
            print(error)
            return nil
        }
        
    }

}

    
    
    
//    func fetchRestaurants(lat: String, long: String, completionHandler: @escaping (([RestaurantData]) -> Void)) {
//        let urlString = "\(RestaurantURL)?lat=\(lat)&lng=\(long)"
//        //        Create URL object
//        if let url = URL(string: urlString) {
//            //        Create a URLSession
//            let session = URLSession(configuration: .default)
//
//            //        Give the session a task
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//
//                if let safeData = data {
//                    if let restaurantData = self.parseJSON(restaurantData: safeData) {
//                       completionHandler(restaurantData)
//                    }
//                }
//            }
//
//            //        Start the task
//            task.resume()
//        }
//    }

    

