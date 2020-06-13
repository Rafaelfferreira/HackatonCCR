//
//  ViewController.swift
//  HackatonCCR
//
//  Created by Rafael Ferreira on 12/06/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum CardState {
        case expanded
        case collapsed
    }

    var cardViewController: CardViewController!
    var visualEffectView: UIVisualEffectView!
    
    var cardHeight: CGFloat = 600
    var cardHandleAreaHeight: CGFloat = 80
    
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
    }

    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        cardViewController = CardViewController(nibName: "CardViewController", bundle: nil)
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        
        cardViewController.view.clipsToBounds = true
    
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleCardTap(reconizer:)))
        let panGestureReconizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handleCardPan(reconizer:)))
        
        cardViewController.handleArea.addGestureRecognizer(tapGestureReconizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureReconizer)

    }
    
    @objc
    func handleCardTap(reconizer:UITapGestureRecognizer) {
    }
    
    @objc
    func handleCardPan(reconizer:UIPanGestureRecognizer) {
        switch reconizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            updateInteractiveTransition(fractionCompleted: 0)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    func animateTransitionIfNedded(state: CardState, duration: TimeInterval){
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
        }
    }
    
    func startInteractiveTransition(state: CardState, duration: TimeInterval){
        if runningAnimations.isEmpty {
            animateTransitionIfNedded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat){
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition(){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}

