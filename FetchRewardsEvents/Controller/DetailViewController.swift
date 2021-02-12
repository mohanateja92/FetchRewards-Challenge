//
//  DetailViewController.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/6/21.
//

import UIKit

protocol FavoriteCellUpdateDelegate: class {
    func updateFavoriteCell(_ indexPath: IndexPath) 
}

class DetailViewController : UIViewController { 
    @IBOutlet weak var detailEventLabel: UILabel!
    @IBOutlet weak var favoriteButton: HeartButton!
    
    weak var delegate: FavoriteCellUpdateDelegate?
    
    var event: EventsInfo?
    var favoriteEventsManager: FavoriteEventsManager?
    var cellIndexPath: IndexPath?
    
    override func viewDidLoad() {
        detailEventLabel.text = event?.title ?? ""
        guard let eventId = event?.id, let favoriteEventsManager = favoriteEventsManager else {return }
        if favoriteEventsManager.containsFav(eventId) {
            favoriteButton.filled = true
        }
        
    }
    
    @IBAction func favoriteButtonClicked(_ sender: HeartButton) {
        guard let eventId = event?.id, let favoriteEventsManager = favoriteEventsManager, let cellIndexPath = cellIndexPath  else { return }
        
        if favoriteEventsManager.containsFav(eventId) {
            favoriteEventsManager.removeFav(eventId)
            favoriteButton.filled = false
        } else {
            favoriteEventsManager.addFav(eventId)
            favoriteButton.filled = true
        }
        self.delegate?.updateFavoriteCell(cellIndexPath)
        //toggle button
        favoriteEventsManager.updateUserDefaults()
    }
}
