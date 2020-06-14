//
//  CardViewController.swift
//  HackatonCCR
//
//  Created by Maria Eduarda Casanova Nascimento on 13/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var elementsFoundLabel: UILabel!
    @IBOutlet weak var conteinerView: UIView!
    
    var detailsViewController : DetailsViewController!
    var numOfElemenstsFound: Int = 2
    
    override func viewDidLoad() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        setElementsLabel()
        conteinerView.isHidden = true
        
        detailsViewController = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        detailsViewController.cardViewController = self
        conteinerView.addSubview(detailsViewController.view)
    }
    
    func setElementsLabel(){
        if numOfElemenstsFound == 0{
            elementsFoundLabel.text = "Não encontramos pontos avaliados na sua rota"
        }
        else if numOfElemenstsFound == 1{
             elementsFoundLabel.text = "Encontramos \(numOfElemenstsFound) ponto avaliado na sua rota"
        }else{
            elementsFoundLabel.text = "Encontramos \(numOfElemenstsFound) pontos avaliados na sua rota"
        }
    }
}

extension  CardViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfElemenstsFound
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("FoundElementsTableViewCell", owner: self, options: nil)?.first as! FoundElementsTableViewCell
        cell.place = Place(name: "Graal 56 (Sul)", percentOfLike: "98% acharam bom", address: "Rod. dos Bandeirantes, Km 56 Chácara Malota, Jundiaí - SP, 13211-510", phone: "+55 (11) 45318612", favorite: false, good_bad: false)
        // set cell information
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as?
            FoundElementsTableViewCell {
            detailsViewController.setView(place: cell.place)
            conteinerView.isHidden = false
            tableView.isHidden = true
        }
    }
    func showTableView(){
        conteinerView.isHidden = true
        tableView.isHidden = false
    }
    
}
