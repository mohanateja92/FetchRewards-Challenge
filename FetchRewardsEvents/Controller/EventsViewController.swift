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
    let totalEvents = 121712
    var pageNumber = 1
    //Original DataSource of all the events
    var events: [EventsInfo]?
    //currEvents represents what we are looking at currently as we are going through search
    var currEvents: [EventsInfo]?
    var eventManager = EventsManager()
    var favoriteEventsManager = FavoriteEventsManager(favoritesArray:[])
    var loadingData = false
    let detailViewControler = DetailViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsView.dataSource = self
        eventsView.delegate = self
        detailViewControler.delegate = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchBarContainerView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
        
        eventsView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: Constants.eventsViewTableCell)
        eventManager.fetchEvents (page: pageNumber, completionHandler: { [weak self] (events) in
            self?.events = events
            self?.currEvents = self?.events
            DispatchQueue.main.async {
                self?.eventsView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteEventsManager.printUserDefaults()
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



