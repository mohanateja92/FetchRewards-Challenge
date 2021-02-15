//
//  DetailViewController.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/6/21.
//

import UIKit

class DetailViewController : UIViewController { 
    @IBOutlet weak var titleViewLabel: UILabel!
    @IBOutlet weak var favoriteButton: HeartButton!
    @IBOutlet weak var eventImageView: EventImageManager!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    
    var event: EventsInfo?
    var favoriteEventsManager: FavoriteEventsUserDefaultsManager?
    var cellIndexPath: IndexPath?
    
    override func viewDidLoad() {
//        let navBarButton = UIBarButtonItem(customView: favoriteButton)
//        self.navigationItem.rightBarButtonItem = navBarButton
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = "Event Details"
        self.eventDateLabel.text = event?.eventDate
        self.eventLocationLabel.text = event?.venue?.display_location ?? ""
        titleViewLabel.text = event?.title ?? ""
        if let imageString = event?.performers?[0].image {
            eventImageView.fetchEventImageFromURL(imageURLString: imageString)
        }
        guard let eventId = event?.id, let favoriteEventsManager = favoriteEventsManager else { return }
        if favoriteEventsManager.containsFav(eventId) {
            favoriteButton.filled = true
        }
    }
    
    @IBAction func favoriteButtonClicked(_ sender: HeartButton) {
        guard let eventId = event?.id, let favoriteEventsManager = favoriteEventsManager  else { return }

        if favoriteEventsManager.containsFav(eventId) {
            favoriteEventsManager.removeFav(eventId)
            favoriteButton.filled = false
        } else {
            favoriteEventsManager.addFav(eventId)
            favoriteButton.filled = true
        }
    }
}
