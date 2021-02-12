//
//  EventsInfo.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/2/21.
//

import Foundation

struct EventsInfo: Decodable {
    var id: Int?
    var title: String?
    let performers: [Performers]?
    let venue: Venue?
    var date_time_utc: String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE, MMM dd yyyy h:mm a"

        let date: Date? = dateFormatterGet.date(from:"2021-02-10T03:30:00")
        return dateFormatterPrint.string(from: date!)
    }
    
}
struct Performers: Decodable {
    let image: String?
}

struct Venue: Decodable {
    let display_location: String?
}
