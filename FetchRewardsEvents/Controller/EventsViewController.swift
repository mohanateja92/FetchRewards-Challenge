//
//  ViewController.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/2/21.
//

import UIKit

final class EventsViewController: UIViewController {
    
    @IBOutlet weak var eventsView: UITableView!
    
    @IBOutlet weak var searchBarContainerView: UIView!
    
    var searchController: UISearchController!
    
    //Original DataSource of all the events
    var events: [EventsInfo]?
    //currEvents represents what we are looking at currently as we are going through search
    var currEvents: [EventsInfo]?
    var eventManager = EventsManager()
    
    struct Constants {
        static let eventsViewTableCell = "com.events.EventCell"
        static let segueIdentifier =  "com.events.DetailViewSegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsView.dataSource = self
        eventsView.delegate = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchBarContainerView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
        
        eventsView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: Constants.eventsViewTableCell)
        eventManager.fetchEvents { [weak self] (events) in
            self?.events = events
            self?.currEvents = self?.events
            DispatchQueue.main.async {
                self?.eventsView.reloadData()
            }
        }
    }
    
    func filterCurrentEvents(searchTerm: String) {
        if searchTerm.count > 0  {
            currEvents = events
            let filteredEvents = currEvents?.filter({ (eventsInfo) -> Bool in
                let parsedTitle = eventsInfo.title?.replacingOccurrences(of: " ", with: "").lowercased() ?? ""
                let parsedSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "").lowercased()
                return parsedTitle.contains(parsedSearchTerm)
            })
            currEvents = filteredEvents
            eventsView.reloadData()
        }
    }
    
    func restoreCurrEvents() {
        currEvents = events
        eventsView.reloadData()
    }
    
}

extension EventsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currEvents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.eventsViewTableCell, for: indexPath) as? TableViewCell else { fatalError("Unable to find the cell for reuse") }
        guard let eventInfo = currEvents?[indexPath.row] else { return UITableViewCell() }
        cell.eventNameLabel.text = eventInfo.title ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.segueIdentifier, sender: nil)
        searchController.isActive = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier{
            if let indexPath = self.eventsView.indexPathForSelectedRow {
                if let controller = segue.destination as? DetailViewController {
                    controller.event = events?[indexPath.row]
                }
            }
        }
    }
    
}

extension EventsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterCurrentEvents(searchTerm: searchText)
        }
    }
}

extension EventsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        if let searchText = searchBar.text {
            filterCurrentEvents(searchTerm: searchText)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        if let searchText = searchBar.text, !searchText.isEmpty{
            restoreCurrEvents()
        }
        
        
    }
}
