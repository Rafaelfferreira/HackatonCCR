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
    @IBOutlet weak var theContainer: UIView!
    @IBOutlet weak var mainView: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
    }
    
    func setupComponent(){
        let controller = UIHostingController(rootView: InfoImageView(listOfInfos: [.restaurante,.banheiro,.chuveiro,.vigia,
        .estacionamento,.lazer,.wifi,.combustivel,.oficina,.adicionar,.whatsapp]))
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(controller)
        theContainer.addSubview(controller.view)
        controller.didMove(toParent: self)
        NSLayoutConstraint.activate([
            controller.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    func setView(place: Place){
        //colocar valores nas labels
    }

}

