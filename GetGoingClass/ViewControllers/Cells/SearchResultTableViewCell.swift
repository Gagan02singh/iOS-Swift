//
//  SearchResultTableViewCell.swift
//  GetGoingClass
//
//  Created by Diven Sambhwani on 1/23/19.
//  Copyright © 2019 SMU. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

   
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var rating: RatingControl!
    @IBOutlet weak var vicinityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
