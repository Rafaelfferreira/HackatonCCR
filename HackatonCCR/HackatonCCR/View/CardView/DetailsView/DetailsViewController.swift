//
//  DetailsViewController.swift
//  HackatonCCR
//
//  Created by Maria Eduarda Casanova Nascimento on 13/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import UIKit
import SwiftUI

class DetailsViewController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var theContainer: UIView!
    //MARK: labels outlets
    @IBOutlet weak var placeAddressLabel: UILabel!
    @IBOutlet weak var placePhoneLabel: UILabel!
    //MARK: buttons outlets
    @IBOutlet weak var notWorthLabel: UILabel!
    @IBOutlet weak var worthLabel: UILabel!
    @IBOutlet weak var badLabel: UILabel!
    @IBOutlet weak var goodLabel: UILabel!
    
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var notWorthButton: UIButton!
    @IBOutlet weak var worthButton: UIButton!
    
    
    @IBAction func ratePrice(_ sender: Any) {
        //popup para valiar preço
    }
    
    @IBAction func rateWorthNo(_ sender: Any) {
        notWorthLabel.isHidden = true
        notWorthButton.isHidden = true
        worthButton.setImage(UIImage(named: "deslike"), for: .normal)
        worthLabel.text = "não vale"
    }
    
    @IBAction func reteWorthYes(_ sender: Any) {
        notWorthLabel.isHidden = true
        notWorthButton.isHidden = true
        worthButton.setImage(UIImage(named: "like"), for: .normal)
        worthLabel.text = "não vale"
    }
    
    @IBAction func rateGood(_ sender: Any) {
        goodButton.setImage(UIImage(named: "like"), for: .normal)
        badButton.isHidden = true
        badLabel.isHidden = true
    }
    
    @IBAction func rateBad(_ sender: Any) {
        goodButton.setImage(UIImage(named: "deslike"), for: .normal)
        badButton.isHidden = true
        badLabel.isHidden = true
        goodLabel.text = "ruim"
    }
    
    //MARK: ---------------
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func setupComponent(infoTypes: [InfosTypes]){
        let controller = UIHostingController(rootView: InfoImageView(listOfInfos: infoTypes))
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(controller)
        theContainer.addSubview(controller.view)
        controller.didMove(toParent: self)
        NSLayoutConstraint.activate([
            controller.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    func setView(place: Place){
        placePhoneLabel.text = place.phone
        placeAddressLabel.text = place.address
        setupComponent(infoTypes: place.infoTypes)
    }
    
}

