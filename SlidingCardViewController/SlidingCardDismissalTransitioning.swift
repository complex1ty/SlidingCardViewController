//
//  DismissalTransitioning.swift
//  SlidingCardViewController
//
//  Created by Fu Qiang on 20/9/18.
//  Copyright © 2018 Fu Qiang. All rights reserved.
//

import UIKit

class SlidingCardDismissalTransitioning: NSObject {
    
    public let interactionController: SlidingCardInteractionController?
    private let property: SlidingCardProperty
    
    init(property: SlidingCardProperty, interactionController: SlidingCardInteractionController?) {
        self.property = property
        self.interactionController = interactionController
    }
}

extension SlidingCardDismissalTransitioning: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return property.transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presented = transitionContext.viewController(forKey: .from) else {return}
        let initialFrame = presented.view.frame
        let finalFrame = presented.view.frame.offsetBy(dx: 0, dy: property.frontViewHeight)
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                presented.view.frame = finalFrame
            }){
            finish in
            let complete = !transitionContext.transitionWasCancelled && finish
            if (!complete) {
                UIView.animate(withDuration: self.property.transitionDuration) {
                    presented.view.frame = initialFrame
                }
            }
            transitionContext.completeTransition(complete)
        }
    }
}

extension SlidingCardDismissalTransitioning: UIViewControllerInteractiveTransitioning {
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
    }
}
