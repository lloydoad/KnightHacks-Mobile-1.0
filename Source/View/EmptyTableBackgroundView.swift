//
//  EmptyTableBackgroundView.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 8/3/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class EmptyTableBackgroundView: UIView {
    
    public static let nibName: String = "EmptyTableBackgroundView"
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var centerOffset: NSLayoutConstraint!
    @IBOutlet private weak var rovarImageView: UIImageView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView() {
        Bundle.main.loadNibNamed(EmptyTableBackgroundView.nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        centerOffset.constant = -5
        rovarImageView.alpha = 0
    }
    
    func animateBackground() {
        centerOffset.constant = -5
        rovarImageView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.rovarImageView.alpha = 1
            self.centerOffset.constant = 0
            self.contentView.layoutIfNeeded()
        }
    }
}
