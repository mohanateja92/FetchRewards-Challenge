//
//  ViewControllerSearchBarExtensions.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/8/21.
//

import UIKit

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
        if let searchText = searchBar.text, !searchText.isEmpty{
            searchController.isActive = false
            restoreCurrEvents()
        }
    }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            restoreCurrEvents()
        }
    }
    
}

