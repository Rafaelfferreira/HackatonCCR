//
//  ScroolViewControler.swift
//  HackatonCCR
//
//  Created by Maria Eduarda Casanova Nascimento on 14/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import UIKit
import SwiftUI

class ScroolViewController: UIViewController {
    var detailsViewController: DetailsViewController!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScroolView()
    }
    
    func setupScroolView() {
        scrollView.frame = .null
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 1000)
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: scrollView.contentSize.height)
        detailsViewController = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        self.addChild(detailsViewController)
        containerView.addSubview(detailsViewController.view)
        scrollView.addSubview(detailsViewController.view)
        
    }
    
    func setView(place: Place){
         detailsViewController.setView(place: place)
    }
}
