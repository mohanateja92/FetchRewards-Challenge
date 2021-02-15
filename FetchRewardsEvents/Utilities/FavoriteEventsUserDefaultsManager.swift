//
//  FavoriteEvents.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/9/21.
//

import Foundation

class FavoriteEventsUserDefaultsManager {
    private var favoritesArray = [Int]()
    private var userDefaults: UserDefaults!
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        self.favoritesArray = userDefaults.object(forKey: Constants.userDefaultsKey) as? [Int] ?? []
    }
    
    func containsFav(_ eventId: Int) -> Bool {
        return favoritesArray.contains(eventId)
    }
    
    func removeFav(_ eventId: Int) {
        guard let index = favoritesArray.firstIndex(of: eventId) else { return }
        favoritesArray.remove(at: index)
        updateUserDefaults()
    }
    
    func addFav(_ eventId: Int) {
        favoritesArray.append(eventId)
        updateUserDefaults()
    }
    
    private func updateUserDefaults() {
        userDefaults.set(favoritesArray, forKey: Constants.userDefaultsKey)
    }
}
