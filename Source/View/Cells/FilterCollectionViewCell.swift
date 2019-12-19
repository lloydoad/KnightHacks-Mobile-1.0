//
//  FilterCollectionViewCell.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/25/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

public class FilterCollectionViewCell: UICollectionViewCell {
    
    public static let identifier: String = "FilterCollectionViewCell"
    public static let nibName: String = "FilterCollectionViewCell"
    
    private let borderThickness: CGFloat = 2.5
    
    @IBOutlet private weak var imageBackgroundView: UIView!
    @IBOutlet private weak var filterIconImageView: UIImageView!
    @IBOutlet private weak var filterLabel: UILabel!
    @IBOutlet private weak var borderView: UIView!
    
    public var model: FilterMenuModel? {
        didSet {
            guard let model = model else { return }
            filterLabel.text = model.name.capitalized
            
            filterIconImageView.image = UIImage(named: model.imageURL)
            guard !model.isLocal else {
                return
            }
            
            ImageRequestSingleton.firebaseGetImage(reference: model.imageURL) { (image) in
                if let image = image, !model.isLocal, self.filterLabel.text != "All" {
                    self.filterIconImageView.image = image
                }
            }
        }
    }
    
    override public var isSelected: Bool {
        didSet {
            guard filterIconImageView != nil else { return }
            if isSelected {
                borderView.layer.borderWidth = borderThickness
            } else {
                borderView.layer.borderWidth = 0
            }
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.borderView.layer.borderColor = BACKGROUND_COLOR.cgColor
        self.initViewLayer(imageBackgroundView, withShadows: true)
        self.initViewLayer(borderView)
        self.filterLabel.font = PARAGRAPH_FONT
    }

    private func initViewLayer(_ view: UIView, withShadows hasShadows: Bool = false) {
        view.layer.cornerRadius = view.frame.height / 2
        
        if hasShadows {
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 1)
            view.layer.shadowRadius = 5
        }
    }
    
    public func setFilterImage(image: UIImage) {
        self.filterIconImageView.image = image
    }
}
