//
//  TableViewCell.swift
//  FetchRewardsEvents
//
//  Created by Mohana G on 2/2/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventImageView: EventImageManager!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventDateTimeLabel: UILabel!
    
    @IBOutlet weak var heartButton: HeartButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
