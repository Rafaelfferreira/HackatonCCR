//
//  InitialViewController.swift
//  HackatonCCR
//
//  Created by Maria Eduarda Casanova Nascimento on 14/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var postoButton: UIButton!
    @IBOutlet weak var oficinaButton: UIButton!
    @IBOutlet weak var restauranteButton: UIButton!
    @IBOutlet weak var adicionarButton: UIButton!
    @IBOutlet weak var ccrButton: UIButton!
    @IBOutlet weak var freteButton: UIButton!
    @IBOutlet weak var lazerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCorner()
    }
    
    func setCorner(){
        postoButton.clipsToBounds = true
        postoButton.layer.cornerRadius = 15
        
        oficinaButton.clipsToBounds = true
        oficinaButton.layer.cornerRadius = 15
        
        restauranteButton.clipsToBounds = true
        restauranteButton.layer.cornerRadius = 15
        
        adicionarButton.clipsToBounds = true
        adicionarButton.layer.cornerRadius = 15
        
        ccrButton.clipsToBounds = true
        ccrButton.layer.cornerRadius = 15
        
        freteButton.clipsToBounds = true
        freteButton.layer.cornerRadius = 15
        
        lazerButton.clipsToBounds = true
        lazerButton.layer.cornerRadius = 15
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
