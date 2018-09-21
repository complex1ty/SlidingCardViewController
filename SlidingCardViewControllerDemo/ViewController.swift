//
//  ViewController.swift
//  SlidingCardViewControllerDemo
//
//  Created by Fu Qiang on 21/9/18.
//  Copyright © 2018 Fu Qiang. All rights reserved.
//

import UIKit
import SnapKit
import SlidingCardViewController

class ViewController: UIViewController {
    
    private lazy var presentButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(presentButtonClickedHandler), for: .touchUpInside)
        return button
    }()
    
    @objc func presentButtonClickedHandler(sender: UIButton) {
        let presented = SlidingCardViewController(halfView)
        presented.modalPresentationStyle = .custom
        present(presented, animated: true, completion: nil)
    }
    
    private lazy var halfView: UIView = {
        let uiView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: view.bounds.height / 2))
        uiView.backgroundColor = .white
        uiView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints{
            (make) -> Void in
            make.center.equalToSuperview()
        }
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(dismissButtonClickedHandler), for: .touchUpInside)
        return button
    }()
    
    @objc func dismissButtonClickedHandler(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(presentButton)
        presentButton.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
        }
    }
    


}

