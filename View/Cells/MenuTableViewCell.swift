//
//  MenuTableViewCell.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/23/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class MenuTableViewCell: UITableViewCell {
    
    public static let identifier: String = "MenuCellIdentifier"

    @IBOutlet private weak var menuLabel: UILabel!
    @IBOutlet private weak var menuImageView: UIImageView!
    @IBOutlet private weak var menuBackgroundView: UIView!
    
    public var model: HomeMenuModel? {
        didSet {
            guard let model = model else { return }
            menuLabel.text = model.title
            menuImageView.image = UIImage(named: model.imageName)
            menuBackgroundView.backgroundColor = model.defaultColor
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.initlayers()
    }
    
    private func initlayers() {
        menuBackgroundView.layer.cornerRadius = 14
        menuBackgroundView.layer.shadowColor = UIColor(hex: 0x000000, alpha: 0.5).cgColor
        menuBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        menuBackgroundView.layer.shadowRadius = 6
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if let baseColor = model?.defaultColor.rgba {
            self.menuBackgroundView.backgroundColor = UIColor(red: baseColor.red, green: baseColor.green, blue: baseColor.blue, alpha: highlighted ? 0.65 : 1)
        }
    }
}
