//
//  FoundElementsTableViewCell.swift
//  HackatonCCR
//
//  Created by Maria Eduarda Casanova Nascimento on 13/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import UIKit

class FoundElementsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentOfLikeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var place: Place!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
