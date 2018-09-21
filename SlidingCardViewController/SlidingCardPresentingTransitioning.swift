//
//  PresentingController.swift
//  SlidingCardViewController
//
//  Created by Fu Qiang on 20/9/18.
//  Copyright © 2018 Fu Qiang. All rights reserved.
//

import UIKit

class SlidingCardPresentingTransitioning: NSObject {
    
    private let property: SlidingCardProperty
    
    init(property: SlidingCardProperty) {
        self.property = property
    }

}

extension SlidingCardPresentingTransitioning: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return property.transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presented = transitionContext.viewController(forKey: .to) else {return}
        let containerView = transitionContext.containerView
        containerView.addSubview(presented.view)
        presented.view.frame = presented.view.frame.offsetBy(dx: 0, dy: property.frontViewHeight)
        
        let finalFrame = transitionContext.finalFrame(for: presented)
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                presented.view.frame = finalFrame
        }){
            finish in
            transitionContext.completeTransition(finish)
        }
    }
}
