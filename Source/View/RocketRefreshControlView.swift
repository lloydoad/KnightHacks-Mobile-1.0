//
//  RocketRefreshControlView.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/28/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

/**
 A custom refresh control view with in-built animation
 */
public class RocketRefreshControlView: UIView {
    
    public static var nibName: String = "RocketRefreshControlView"
    
    @IBOutlet private weak var rocketImage: UIImageView!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var imageXAnchor: NSLayoutConstraint!
    
    private var isAnimating: Bool = false
    private let startXOffset: CGFloat = -90
    private let endXOffset: CGFloat = 420
    
    public var refreshControl: UIRefreshControl! {
        didSet {
            self.translatesAutoresizingMaskIntoConstraints = false
            boundEdges(of: self, to: refreshControl, with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView() {
        Bundle.main.loadNibNamed(RocketRefreshControlView.nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = BACKGROUND_COLOR
        
        imageXAnchor.constant = startXOffset
        rocketImage.transform = CGAffineTransform(rotationAngle: (.pi/2))
    }
    
    final public func startAnimation() {
        
        guard refreshControl != nil, refreshControl.isRefreshing, !isAnimating else { return }
        
        let timingFunction = CAMediaTimingFunction(controlPoints: 4.6/6.0, 0.25, 4/6.0, 1)
        
        guard refreshControl != nil, refreshControl.isRefreshing else {
            return
        }
        
        self.isAnimating = true
        self.rocketImage.alpha = 1
        
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(timingFunction)
        
        UIView.animate(withDuration: 2.0, animations: {
            self.imageXAnchor.constant = self.endXOffset
            self.refreshControl.layoutIfNeeded()
        }) { (_) in
            self.refreshControl.endRefreshing()
            self.imageXAnchor.constant = self.startXOffset
            self.rocketImage.alpha = 0
            self.isAnimating = false
        }
        
        CATransaction.commit()
    }
}
