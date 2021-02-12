//
//  FavoriteEvents.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/9/21.
//

import Foundation

class FavoriteEventsManager {
    var favoritesArray = [Int]()
    let userDefaults = UserDefaults.standard
    
    init() {
        self.favoritesArray = userDefaults.object(forKey: Constants.userDefaultsKey) as? [Int] ?? []
    }
    
    func containsFav(_ eventId: Int) -> Bool {
        //CHHEECKKK HEREEE
        return favoritesArray.contains(eventId)
    }
    
    func removeFav(_ eventId: Int) {
        guard let index = favoritesArray.firstIndex(of: eventId) else{ return }
        favoritesArray.remove(at: index)
    }
    
    func addFav(_ eventId: Int) {
        favoritesArray.append(eventId)
    }
    
    func updateUserDefaults() {
        userDefaults.set(favoritesArray, forKey: Constants.userDefaultsKey)
    }
    
    func printUserDefaults() {
        let favorites = userDefaults.object(forKey: Constants.userDefaultsKey) as? [Int]
        print( "\(favorites ?? [])")
    }
}
