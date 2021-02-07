//
//  ViewController.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/2/21.
//

import UIKit

final class EventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var eventsView: UITableView!
    var events: [EventsInfo]?
    var eventManager = EventsManager()
    
    struct Constants {
        static let eventsViewTableCell = "com.events.EventCell"
        static let segueIdentifier =  "com.events.DetailViewSegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsView.dataSource = self
        eventsView.delegate = self
        eventsView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: Constants.eventsViewTableCell)
        eventManager.fetchEvents { [weak self] (events) in
            self?.events = events
            DispatchQueue.main.async {
                self?.eventsView.reloadData()
            }
        }
    }
    
}

extension EventsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.eventsViewTableCell, for: indexPath) as? TableViewCell else { fatalError("Unable to find the cell for reuse") }
        guard let eventInfo = events?[indexPath.row] else { return UITableViewCell() }
        cell.eventNameLabel.text = eventInfo.title ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.segueIdentifier, sender: nil)
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
