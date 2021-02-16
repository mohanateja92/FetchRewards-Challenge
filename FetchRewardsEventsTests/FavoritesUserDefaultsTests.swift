//
//  FavoritesUserDefaultsTests.swift
//  FetchRewardsEventsTests
//
//  Created by Mohana G on 2/14/21.
//

import XCTest
@testable import FetchRewardsEvents

class FavoritesUserDefaultsTests: XCTestCase {
    var mockUserDefaults = MockUserDefaults()
    var favouriteManager: FavoriteEventsUserDefaultsManager?
    
    override func setUpWithError() throws {
        favouriteManager = FavoriteEventsUserDefaultsManager(userDefaults: mockUserDefaults)
    }
    
    override func tearDownWithError() throws {
        mockUserDefaults.clear()
        favouriteManager = nil
    }
    
    func test_add_favorites_to_userdefaults() throws {
        favouriteManager?.addFav(12345)
        XCTAssertEqual(mockUserDefaults.object(forKey: Constants.userDefaultsKey) as! [Int], [12345])
    }
    
    func test_remove_favorites_from_userdefaults() throws {
        favouriteManager?.removeFav(12345)
        XCTAssertEqual(mockUserDefaults.object(forKey: Constants.userDefaultsKey) as? [Int], nil)
    }
    
    func test_contains_favorites_in_userdefaults() throws {
        favouriteManager?.addFav(123456)
        XCTAssertEqual(favouriteManager?.containsFav(123456), true)
    }
    
    func test_does_not_contains_favorites_in_userdefaults() throws {
        XCTAssertEqual(favouriteManager?.containsFav(1234), false)
    }
    
    
    
    
}
