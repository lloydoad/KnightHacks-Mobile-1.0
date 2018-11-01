//
//  ErrorPopUpViewController.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 10/31/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class ErrorPopUpViewController: UIView {
    let Y_ANIMATION_OFFSET: CGFloat = -27
    let ON_LOAD_DELAY = 0.1
    let ANIMATION_IN_TIME = 0.7
    let ANIMATION_OUT_TIME = 0.5
    let TIME_ON_SCREEN = 3.0
    
    var errorMessage = "Error"
    var customFrame: CGRect = {
        let X_PADDING: CGFloat = 20
        let Y_PADDING: CGFloat = 10
        let HEIGHT: CGFloat = 60
        let WIDTH = UIScreen.main.bounds.width - (2 * X_PADDING)
        let FRAME = CGRect(x: X_PADDING, y: UIScreen.main.bounds.height - HEIGHT + 10, width: WIDTH, height: HEIGHT)
        return FRAME
    }()
    
    init(message: String) {
        super.init(frame: customFrame)
        self.backgroundColor = .white
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.2, height: 0.3)
        self.layer.shadowRadius = 0.8
        self.layer.cornerRadius = 14
        self.layer.shadowOpacity = 1
        
        errorMessage = message
        addErrorLabel(with: errorMessage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addErrorLabel(with text: String) {
        let messageLabel = UILabel(frame: customFrame)
        messageLabel.numberOfLines = 0
        messageLabel.text = errorMessage
        messageLabel.textAlignment = .center
        messageLabel.font = MAJOR_REGULAR_FONT
        
        self.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
    
    func present() {
        let TRANSLATE_ON_Y_AXIS = CGAffineTransform(translationX: 0, y: Y_ANIMATION_OFFSET)
        let TRANSLATE_OFFSCREEN = CGAffineTransform(translationX: 0, y: -Y_ANIMATION_OFFSET + 30)
        let WINDOW = UIApplication.shared.keyWindow!
        
        self.alpha = 0.7
        WINDOW.addSubview(self)
        
        UIView.animate(withDuration: ANIMATION_IN_TIME, delay: ON_LOAD_DELAY, options: .curveEaseOut, animations: {
            self.transform = TRANSLATE_ON_Y_AXIS
            self.alpha = 1
        }) { (_) in
            UIView.animate(withDuration: self.ANIMATION_OUT_TIME, delay: self.TIME_ON_SCREEN, options: .curveEaseIn, animations: {
                self.transform = TRANSLATE_OFFSCREEN
                self.alpha = 0
            }, completion: { (_) in
                self.removeFromSuperview()
            })
        }
    }
}
