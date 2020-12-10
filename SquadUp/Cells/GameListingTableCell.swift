//
//  GameListingTableCellCollectionViewCell.swift
//  SquadUp
//
//  Created by Matthew Goldfine on 12/8/20.
//

import UIKit

class GameListingTableCell: UITableViewCell {
    
    @IBOutlet weak var listingTitle: UILabel!
    @IBOutlet weak var listingDate: UILabel!
    @IBOutlet weak var listingSummary: UILabel!
    @IBOutlet weak var listingAuthor: UILabel!
    @IBOutlet weak var listingSeekingCount: UILabel!
    @IBOutlet weak var cellContainer: UIStackView!

}
