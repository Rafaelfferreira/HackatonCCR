//
//  CardViewController.swift
//  HackatonCCR
//
//  Created by Maria Eduarda Casanova Nascimento on 13/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    //MARK: details view outlets
    @IBAction func backFromDetails(_ sender: Any) {
        conteinerView.isHidden = true
        placeNameLabel.isHidden = true
        placePercentLabel.isHidden = true
        placeBackButton.isHidden = true
        placeImageLike.isHidden = true
        elementsFoundLabel.isHidden = false
        tableView.isHidden = false
    }
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placePercentLabel: UILabel!
    @IBOutlet weak var placeImageLike: UIImageView!
    @IBOutlet weak var placeBackButton: UIButton!
    @IBOutlet weak var conteinerView: UIView!
    
    
    //MARK: card view
    var detailsViewController : DetailsViewController!
    var numOfElemenstsFound: Int = 2
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var elementsFoundLabel: UILabel!
    override func viewDidLoad() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        setElementsLabel()
        setDetailsView()
    }
    
    func setDetailsView(){
        conteinerView.isHidden = true
        detailsViewController = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        conteinerView.addSubview(detailsViewController.view)
        placeNameLabel.isHidden = true
        placePercentLabel.isHidden = true
        placeBackButton.isHidden = true
        placeImageLike.isHidden = true
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
        cell.place = Place(name: "dsdsndsndsds", percentOfLike: "98% acharam bom", address: "Rod. dos Bandeirantes, Km 56 Chácara Malota, Jundiaí - SP, 13211-510", phone: "+55 (11) 45318612", favorite: false, good_bad: false)
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
            placeNameLabel.text = cell.place.name
            placePercentLabel.text = cell.place.percentOfLike
            tableView.isHidden = true
            conteinerView.isHidden = false
            placeNameLabel.isHidden = false
            placePercentLabel.isHidden = false
            placeBackButton.isHidden = false
            placeImageLike.isHidden = false
            elementsFoundLabel.isHidden = true
        }
    }
}
