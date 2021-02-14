//
//  ViewControllerTableViewExtensions.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/8/21.
//

import UIKit

extension EventsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentEvents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.eventsViewTableCell, for: indexPath) as? TableViewCell else { fatalError("Unable to find the cell for reuse") }
        guard let eventInfo = currentEvents?[indexPath.row] else { return UITableViewCell() }
        cell.heartButton.isHidden = !(eventInfo.isFavorite ?? false)
        cell.eventNameLabel.text = eventInfo.title ?? ""
        cell.eventLocationLabel.text = eventInfo.venue?.display_location ?? ""
        cell.eventDateTimeLabel.text = eventInfo.eventDate
        if let imageString = eventInfo.performers?[0].image {
            cell.eventImageView.fetchEventImageFromURL(imageURLString: imageString)
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
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: eventsTableView.bounds.width, height: CGFloat(44))
        self.eventsTableView.tableFooterView = spinner
        self.eventsTableView.tableFooterView?.isHidden = false
        
        loadingData = true
        pageNumber += 1
        eventManager.fetchEvents (page: pageNumber, completionHandler: { [weak self] (events) in
            self?.events?.append(contentsOf: events)
            self?.currentEvents = self?.events
            DispatchQueue.main.async {
                self?.eventsTableView.tableFooterView?.isHidden = true
                self?.eventsTableView.reloadData()
                self?.loadingData = false
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier{
            if let indexPath = self.eventsTableView.indexPathForSelectedRow {
                if let controller = segue.destination as? DetailViewController {
                    controller.event = events?[indexPath.row]
                    controller.favoriteEventsManager = favoriteEventsManager
                }
            }
        }
    }
    
}
