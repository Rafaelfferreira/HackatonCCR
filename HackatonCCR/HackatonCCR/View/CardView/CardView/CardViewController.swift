//
//  CardViewController.swift
//  HackatonCCR
//
//  Created by Maria Eduarda Casanova Nascimento on 13/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    //MARK: scrool view outlets
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
    var scroolViewController : ScroolViewController!
    var numOfElemenstsFound: Int = 0
    var listOfPlaces: [Place] = []
    
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var elementsFoundLabel: UILabel!
    
    //MARK: --------------------------
    override func viewDidLoad() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        elementsFoundLabel.text = "Busque um local"
        setDetailsView()
//        getValuesForTableView()
    }
    
    func getValuesForTableView(){
        //buscar informaçao sobre lugares
        numOfElemenstsFound = 2
        listOfPlaces = [Place(name: point1.name!, percentOfLike: "93% acharam bom", address: point1.addr!, phone: point1.phone!, favorite: false, good_bad: false, infoTypes: [.banheiro,.combustivel,.restaurante,.wifi,.adicionar,.whatsapp]), Place(name: point2.name!, percentOfLike: "86% acharam bom", address: point2.addr!, phone: point2.phone!, favorite: false, good_bad: false, infoTypes: [.banheiro,.combustivel,.restaurante,.wifi,.adicionar,.whatsapp])]
        tableView.reloadData()
        setElementsLabel()
    }
    
    func setDetailsView(){
        conteinerView.isHidden = true
        scroolViewController = ScroolViewController(nibName: "ScroolViewController", bundle: nil)
        conteinerView.addSubview(scroolViewController.view)
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
        let place = listOfPlaces[indexPath.row]
        let cell = Bundle.main.loadNibNamed("FoundElementsTableViewCell", owner: self, options: nil)?.first as! FoundElementsTableViewCell
        cell.setCellInformations(place: place)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as?
            FoundElementsTableViewCell {
            scroolViewController.setView(place: cell.place)
            placeNameLabel.text = cell.place.name
            placePercentLabel.text = cell.place.percentOfLike
            tableView.isHidden = true
            elementsFoundLabel.isHidden = true
            
            conteinerView.isHidden = false
            placeNameLabel.isHidden = false
            placePercentLabel.isHidden = false
            placeBackButton.isHidden = false
            placeImageLike.isHidden = false
            
        }
    }
}
