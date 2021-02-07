//
//  DetailViewController.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/6/21.
//

import UIKit

class DetailViewController :UIViewController { 
    @IBOutlet weak var detailEventLabel: UILabel!
    var event: EventsInfo?
    
    override func viewDidLoad() {
        detailEventLabel.text = event?.title ?? ""
    }
    
}
