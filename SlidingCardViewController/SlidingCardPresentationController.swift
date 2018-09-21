//
//  PresentationController.swift
//  SlidingCardViewController
//
//  Created by Fu Qiang on 20/9/18.
//  Copyright © 2018 Fu Qiang. All rights reserved.
//

import UIKit
import SnapKit

class SlidingCardPresentationController: UIPresentationController {
    
    private let property: SlidingCardProperty
    
    init(property: SlidingCardProperty ,presentedViewController: UIViewController, presenting: UIViewController?) {
        print("init")
        self.property = property
        super.init(presentedViewController: presentedViewController, presenting: presenting)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else {return}
        let dimView = UIView()
        let dimColor = property.backViewDimColor
        dimView.backgroundColor = dimColor.withAlphaComponent(0)
        dimView.accessibilityIdentifier = "dimView"
        containerView.addSubview(dimView)
        dimView.snp.makeConstraints{
            (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        let finalAlpha: CGFloat = property.backViewDimOpacity
        let presentingCornerRadius = property.backViewCornerRadius
        let transform = CGAffineTransform(scaleX: property.backViewDepthScale, y: property.backViewDepthScale)
        presentingViewController.view.layer.cornerRadius = 0
        presentingViewController.transitionCoordinator?.animate(
            alongsideTransition: { _ -> Void in
                self.presentingViewController.view.transform = transform
                self.presentingViewController.view.layer.cornerRadius = presentingCornerRadius
                dimView.backgroundColor = dimColor.withAlphaComponent(finalAlpha)},
            completion: nil)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
    }
    
    override func dismissalTransitionWillBegin() {
        guard let containerView = containerView else {return}
        let transform = CGAffineTransform(scaleX: 1 / property.backViewDepthScale, y: 1 / property.backViewDepthScale)
        let dimView: UIView? = containerView.subviews.first{$0.accessibilityIdentifier == "dimView"}
        
        let finalAlpha: CGFloat = 0
        presentingViewController.transitionCoordinator?.animate(
            alongsideTransition: { _ -> Void in
                self.presentingViewController.view.transform = transform
                self.presentingViewController.view.layer.cornerRadius = 0
                dimView?.backgroundColor = dimView?.backgroundColor?.withAlphaComponent(finalAlpha)},
            completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if (completed) {
            let dimView = containerView?.subviews.first{$0.accessibilityIdentifier == "dimView"}
            dimView?.removeFromSuperview()
            let backgroundView = containerView?.subviews.first{$0.accessibilityIdentifier == "backgroundView"}
            backgroundView?.removeFromSuperview()
        }
        super.dismissalTransitionDidEnd(completed)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    }
}
