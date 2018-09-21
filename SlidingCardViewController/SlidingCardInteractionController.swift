//
//  SwipeInteractionController.swift
//  SlidingCardViewController
//
//  Created by Fu Qiang on 20/9/18.
//  Copyright © 2018 Fu Qiang. All rights reserved.
//

import UIKit

class SlidingCardInteractionController: UIPercentDrivenInteractiveTransition {
    
    public var interactionInProgress = false
    
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    private var property: SlidingCardProperty
    
    init(viewController: UIViewController, property: SlidingCardProperty) {
        self.property = property
        super.init()
        self.viewController = viewController
        prepareGestureRecognizer(in: viewController.view)
    }
    
    private func prepareGestureRecognizer(in view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        
        var progress = (translation.y / property.frontViewHeight)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))

        switch gestureRecognizer.state {
        case .began:
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
            
        case .changed:
            shouldCompleteTransition = progress > property.autoDismissalInteractionPercentage
            update(progress)
            
        case .cancelled:
            interactionInProgress = false
            cancel()
            
        case .ended:
            interactionInProgress = false
            if shouldCompleteTransition {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
}
