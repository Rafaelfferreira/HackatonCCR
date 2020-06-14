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
    

    func setCellInformations(place: Place){
        self.place = place
        nameLabel.text = place.name
        percentOfLikeLabel.text = place.percentOfLike
        addressLabel.text = place.address
    }
}
