//
//  MockUserDefaults.swift
//  FetchRewardsEventsTests
//
//  Created by Mohana G on 2/14/21.
//

import Foundation

class MockUserDefaults: UserDefaults {
    var mockEvents = [String: [Int]]()
    
    convenience init() {
        self.init(suiteName: "Mock User Defaults")!
    }
    
    override init?(suiteName suitename: String?) {
        UserDefaults().removePersistentDomain(forName: suitename!)
        super.init(suiteName: suitename)
    }
    
    func clear() {
        UserDefaults().removePersistentDomain(forName: "Mock User Defaults")
    }
    
    override func set(_ value: Any?, forKey defaultName: String) {
        if let value = value as? [Int] {
            self.mockEvents[defaultName] = value
        }
    }
    
    override func object(forKey defaultName: String) -> Any? {
        return mockEvents[defaultName]
    }
}
