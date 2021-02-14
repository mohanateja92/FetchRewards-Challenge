//
//  ViewController.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/2/21.
//

import UIKit

final class EventsViewController: UIViewController {
    
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var searchBarContainerView: UIView!
    var searchController: UISearchController!
    let totalEvents = 121712
    var pageNumber = 1
    //Original DataSource of all the events
    var events: [EventsInfo]?
    //currentEvents represents what we are looking at currently as we are going through search
    var currentEvents: [EventsInfo]?
    var eventManager = EventsManager()
    var favoriteEventsManager = FavoriteEventsManager()
    var loadingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        eventsTableView.rowHeight = UITableView.automaticDimension
        eventsTableView.scrollsToTop = true
    
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        //searchBarContainerView.addSubview(searchController.searchBar)
        self.navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        eventsTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: Constants.eventsViewTableCell)
        eventManager.fetchEvents (page: pageNumber, completionHandler: { [weak self] (events) in
            self?.events = events
            self?.currentEvents = self?.events
            DispatchQueue.main.async {
                self?.eventsTableView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Events"
        favoriteEventsManager.printUserDefaults()
        eventsTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
    }
    
    func filterCurrentEvents(searchTerm: String) {
        if searchTerm.count > 0  {
            currentEvents = events
            let filteredEvents = currentEvents?.filter({ (eventsInfo) -> Bool in
                let parsedTitle = eventsInfo.title?.replacingOccurrences(of: " ", with: "").lowercased() ?? ""
                let parsedSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "").lowercased()
                return parsedTitle.contains(parsedSearchTerm)
            })
            currentEvents = filteredEvents
            eventsTableView.reloadData()
        }
    }
    
    func restoreCurrEvents() {
        currentEvents = events
        eventsTableView.reloadData()
    }
}



