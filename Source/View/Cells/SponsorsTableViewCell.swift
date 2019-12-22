//
//  SponsorsTableViewCell.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/28/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class SponsorsTableViewCell: UITableViewCell {
    
    public static let identifier: String = "SponsorsCellIdentifer"
    
    @IBOutlet weak var sponsorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tagStack: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var customBackgroundView: UIView!
    
    var model: SponsorModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.name
            descriptionLabel.text = model.description
            locationLabel.text = model.location
            addTags(filters: model.filters)
            
            guard let url = model.imageURL else { return }
            ImageRequestSingleton.firebaseGetImage(reference: url) { (image) in
                if let image = image {
                    self.sponsorImageView.image = image
                } else {
                    print("couldnt fetch image")
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = TITLE_FONT
        nameLabel.textColor = BACKGROUND_COLOR
        descriptionLabel.font = PARAGRAPH_FONT
        addSpecifiedShadow(customBackgroundView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) { }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) { }
    
    private func addTags(filters: [FilterMenuModel]) {
        tagStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        filters.enumerated().forEach {
            guard $0.offset < 3 else { return }
            tagStack.addArrangedSubview(createTagInView(defaultText: $0.element.name.capitalized))
        }
        tagStack.addArrangedSubview(UIView())
    }
}
