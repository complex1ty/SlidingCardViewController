//
//  SlidingCardViewController.swift
//  SlidingCardViewController
//
//  Created by Fu Qiang on 20/9/18.
//  Copyright © 2018 Fu Qiang. All rights reserved.
//

import UIKit
import SnapKit

open class SlidingCardViewController: UIViewController {
    public var property = SlidingCardProperty()
    
    private var slidingCardInteractionController: SlidingCardInteractionController?
    private let contentView: UIView
    private var roundedShadowLayer: CAShapeLayer!
    private var containerView: UIView
    
    public required init(_ containerView: UIView) {
        self.contentView = containerView
        self.containerView = UIView(frame: containerView.frame)
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        modalPresentationCapturesStatusBarAppearance = true
        transitioningDelegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        containerView.addSubview(contentView)
        view.addSubview(containerView)
        view.backgroundColor = .clear
        containerView.snp.makeConstraints{
            (make) -> Void in
            make.bottom.equalToSuperview()
            make.height.equalTo(containerView.bounds.height)
            make.centerX.equalTo(view.bounds.midX)
            make.width.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        property.frontViewHeight = contentView.bounds.height
        modalPresentationStyle = .overCurrentContext
        slidingCardInteractionController = SlidingCardInteractionController(viewController: self, property: property)
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let path = UIBezierPath(roundedRect: containerView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: property.frontViewCornerRadius, height: property.frontViewCornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        containerView.layer.shadowPath = path.cgPath
        containerView.layer.shadowOpacity = property.frontViewShadowOpacity
        containerView.layer.shadowColor = property.frontViewShadowColor.cgColor
        containerView.layer.shadowOffset = property.frontViewShadowOffset
        contentView.layer.mask = mask
        contentView.layer.masksToBounds = true
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

extension SlidingCardViewController: UIViewControllerTransitioningDelegate {
    open func animationController(forPresented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlidingCardPresentingTransitioning(property: property)
    }
    
    open func animationController(forDismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let dismissed = forDismissed as? SlidingCardViewController else {return nil}
        return SlidingCardDismissalTransitioning(
            property: property,
            interactionController: dismissed.slidingCardInteractionController)
    }
    
    open func presentationController(forPresented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = SlidingCardPresentationController(property: property, presentedViewController: forPresented, presenting: presenting)
        return presentationController
    }
    
    open func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? SlidingCardDismissalTransitioning,
            let interactionController = animator.interactionController,
            interactionController.interactionInProgress else {return nil}
        return interactionController
    }

}
