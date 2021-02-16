//
//  FetchRewardsEventsTests.swift
//  FetchRewardsEventsTests
//
//  Created by Mohana G on 2/2/21.
//

import XCTest
@testable import FetchRewardsEvents

class EventsInfoTests: XCTestCase {

    private let eventsInfoAttributes = Data("""
    {
              "id" : 5344170,
              "datetime_utc": "2021-02-14T08:30:00",
              "venue": {
                    "display_location": "Tallahassee, FL"
               },
              "performers": [{
                "image": "https://seatgeek.com/images/performers-landscape/miami-hurricanes-womens-basketball-23db85/11995/huge.jpg"
              }],
             "title": "Miami Hurricanes at Florida State Seminoles Women's Basketball"
              
    }
    """.utf8)
    
    var eventsInfo: EventsInfo?
    
    override func setUpWithError() throws {
        eventsInfo = try? JSONDecoder().decode(EventsInfo.self, from: eventsInfoAttributes)
    }
    override func tearDownWithError() throws {
       eventsInfo = nil
    }
    
    func test_convert_datetimeUTC_to_EEEEMMMddyyyyhmma_Format() throws {
        XCTAssertEqual(eventsInfo!.eventDate, "Sunday, Feb 14 2021 8:30 AM")
    }
    
    func test_convert_datetimeUTC_to_EEEEMMMddyyyyhmma_Format_incorrectResults() throws {
        XCTAssertNotEqual(eventsInfo!.eventDate, "Feb 14 2021 8:30 AM")
    }

}
