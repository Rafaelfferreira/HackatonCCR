//
//  DetailsViewController.swift
//  HackatonCCR
//
//  Created by Maria Eduarda Casanova Nascimento on 13/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var cardViewController: CardViewController!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentOfLikeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismiss(_ sender: UIButton) {
        if let controller = cardViewController{
            controller.showTableView()
        }
    }
    
    func setView(place: Place){
        nameLabel.text = place.name
        percentOfLikeLabel.text = place.percentOfLike
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
