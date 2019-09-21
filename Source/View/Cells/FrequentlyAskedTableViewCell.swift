//
//  FrequentlyAskedTableViewCell.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/28/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class FrequentlyAskedTableViewCell: UITableViewCell {
    
    public static let identifier: String = "FrequentlyAskedCellIdentifier"
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var customBackgroundView: UIView!
    @IBOutlet weak var expandContractButton: UIButton!
    
    public var model: FrequentlyAskedModel? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.question
            descriptionLabel.text = model.answer
            let imageName = descriptionLabel.text == "" ? "show more button" : "show less button"
            expandContractButton.setBackgroundImage(UIImage(named: imageName), for: .normal)
            expandContractButton.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSpecifiedShadow(customBackgroundView)
        titleLabel.font = TITLE_FONT
        descriptionLabel.font = PARAGRAPH_FONT
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) { }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) { }
 
}
