//
//  InitialViewController.swift
//  HackatonCCR
//
//  Created by Maria Eduarda Casanova Nascimento on 14/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func findGasStation(_ sender: Any) {
        performSegue(withIdentifier: "main", sender: searchFor.gasStation)
    }
    
    @IBAction func findRestaurant(_ sender: Any) {
        performSegue(withIdentifier: "main", sender: searchFor.restaurant)
    }
    
    @IBAction func findMechanical(_ sender: Any) {
        performSegue(withIdentifier: "main", sender: searchFor.mechanical)
    }
    
    
    @IBAction func findRecreationArea(_ sender: Any) {
        performSegue(withIdentifier: "main", sender: searchFor.recreation)
    }
    
    @IBAction func costOfFreight(_ sender: Any) {
        //page not implemented
    }
    
    @IBAction func CCRPage(_ sender: Any) {
        //page not implemented
    }
    
    
    @IBAction func addNewPlace(_ sender: Any) {
        //page not implemented
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "main" {
            if let destination  = segue.destination as? ViewController{
//                set something
                print("ok")
            }
        }
    }
}

enum searchFor {
    case gasStation
    case restaurant
    case mechanical
    case recreation
}
