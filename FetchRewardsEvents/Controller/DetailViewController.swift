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
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: FavoriteCellUpdateDelegate?
    
    var event: EventsInfo?
    var favoriteEventsManager: FavoriteEventsManager?
    var cellIndexPath: IndexPath?
    
    override func viewDidLoad() {
        detailEventLabel.text = event?.title ?? ""
    }
    
    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        guard let eventId = event?.id, let favoriteEventsManager = favoriteEventsManager, let cellIndexPath = cellIndexPath  else { return }
        
        if favoriteEventsManager.containsFav(eventId) {
            favoriteEventsManager.removeFav(eventId)
//            unlike button
        } else {
            favoriteEventsManager.addFav(eventId)
//            like button
        }
        self.delegate?.updateFavoriteCell(cellIndexPath)
        //toggle button
        favoriteEventsManager.updateUserDefaults()
    }
}
