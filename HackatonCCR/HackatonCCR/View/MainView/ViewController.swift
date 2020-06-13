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
    
    var cardHeight: CGFloat = 405
    var cardHandleAreaHeight: CGFloat = 106
    
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
}

//MARK: Card View setup and Animation
extension ViewController{
    
    func setupCard() {
            visualEffectView = UIVisualEffectView()
            visualEffectView.frame = self.view.frame
            self.view.addSubview(visualEffectView)
            
            cardViewController = CardViewController(nibName: "CardViewController", bundle: nil)
            self.addChild(cardViewController)
            self.view.addSubview(cardViewController.view)
            
            cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
            
            cardViewController.view.clipsToBounds = true
            cardViewController.view.layer.cornerRadius = 15
            
            let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleCardTap(recognizer:)))
            let panGestureReconizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handleCardPan(recognizer:)))
            
            cardViewController.handleArea.addGestureRecognizer(tapGestureReconizer)
            cardViewController.handleArea.addGestureRecognizer(panGestureReconizer)

        }
        
    @objc
    func handleCardTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
        
    @objc
    func handleCardPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.cardViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
        
    func animateTransitionIfNeeded(state: CardState, duration: TimeInterval){
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
                
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
        
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
                
                
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
                
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
                
        }
    }
        
    func startInteractiveTransition(state: CardState, duration: TimeInterval){
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
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
