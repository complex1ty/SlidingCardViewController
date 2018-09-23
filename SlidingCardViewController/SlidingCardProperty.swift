//
//  SlidingCardProperty.swift
//  SlidingCardViewController
//
//  Created by Fu Qiang on 21/9/18.
//  Copyright © 2018 Fu Qiang. All rights reserved.
//

import UIKit
import Foundation

public struct SlidingCardProperty {
    public var transitionDuration: TimeInterval = 0.5
    public var frontViewCornerRadius: CGFloat = UIScreen.main.bounds.width / 20
    public var frontViewHeight: CGFloat = UIScreen.main.bounds.height
    public var frontViewShadowOpacity: Float = 0.1
    public var frontViewShadowColor: UIColor = .black
    public var frontViewShadowOffset: CGSize = CGSize(width: 0, height: 0)
    public var backViewCornerRadius: CGFloat = UIScreen.main.bounds.width / 40
    public var backViewDepthScale: CGFloat = 0.9
    public var backViewDimColor: UIColor = .black
    public var backViewDimOpacity: CGFloat = 0.2
    public var autoDismissalInteractionPercentage: CGFloat = 0.5
}

