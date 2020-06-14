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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setView(place: Place){
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
struct Images {
    var body: some View{
        List{
            Image("bad")
            Image("bad")
            Image("bad")
        }
    }
}
