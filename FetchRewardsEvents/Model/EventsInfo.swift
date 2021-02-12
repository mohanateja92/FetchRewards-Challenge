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
    var isFavorite: Bool? {
        guard let id = self.id else {
            return false
        }
        return  FavoriteEventsManager().containsFav(id)
    }
    let performers: [Performers]?
    let venue: Venue?
    var datetime_utc: String?
    
    var eventDate: String {
        guard let eventDate = self.datetime_utc else { return "" }
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE, MMM dd yyyy h:mm a"

        guard let date = dateFormatterGet.date(from: eventDate) else { return "" }
        return dateFormatterPrint.string(from: date)
    }
}
struct Performers: Decodable {
    let image: String?
}

struct Venue: Decodable {
    let display_location: String?
}
