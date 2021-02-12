//
//  ViewControllerTableViewExtensions.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/8/21.
//

import UIKit

extension EventsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currEvents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.eventsViewTableCell, for: indexPath) as? TableViewCell else { fatalError("Unable to find the cell for reuse") }
        guard let eventInfo = currEvents?[indexPath.row], let id = eventInfo.id else { return UITableViewCell() }
        
        if favoriteEventsManager.containsFav(id) {
            cell.heartButton.isHidden = false
        } else {
            cell.heartButton.isHidden = true
        }
    
        cell.eventNameLabel.text = eventInfo.title ?? ""
        cell.eventLocationLabel.text = eventInfo.venue?.display_location ?? ""
        cell.eventDateTimeLabel.text = eventInfo.date_time_utc ?? ""
        if let imageString = eventInfo.performers?[0].image {
            //cell.eventImageView.fetchEventImageFromURL(imageURLString: imageString)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.segueIdentifier, sender: nil)
        searchController.isActive = false
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let eventsCount = events?.count, eventsCount < totalEvents {
            let lastElement = eventsCount - 1
            if !loadingData && indexPath.row == lastElement {
                loadMoreData()
            }
        }
    }
    
    func loadMoreData() {
        if loadingData { return }
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: eventsView.bounds.width, height: CGFloat(44))
        self.eventsView.tableFooterView = spinner
        self.eventsView.tableFooterView?.isHidden = false
        
        loadingData = true
        pageNumber += 1
        eventManager.fetchEvents (page: pageNumber, completionHandler: { [weak self] (events) in
            self?.events?.append(contentsOf: events)
            self?.currEvents = self?.events
            DispatchQueue.main.async {
                self?.eventsView.tableFooterView?.isHidden = true
                self?.eventsView.reloadData()
                self?.loadingData = false
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier{
            if let indexPath = self.eventsView.indexPathForSelectedRow {
                if let controller = segue.destination as? DetailViewController {
                    controller.delegate = self
                    controller.event = events?[indexPath.row]
                    controller.favoriteEventsManager = favoriteEventsManager
                    controller.cellIndexPath = indexPath
                }
            }
        }
    }
    
}

extension EventsViewController: FavoriteCellUpdateDelegate {
    func updateFavoriteCell(_ indexPath: IndexPath) {
        eventsView.reloadRows(at: [indexPath], with: .none)
    }
}


