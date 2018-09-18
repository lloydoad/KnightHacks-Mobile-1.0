//
//  FormattedUITableViewCell.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 9/16/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

class DynamicTableViewCell: UITableViewCell {
    static let identifier: String = "DynamicTableViewCell"
    
    // margins, borders and sizes
    let xMargin: CGFloat = 23
    let yMargin: CGFloat = 8
    let backgroundInnerMargin: CGFloat = 15
    
    // cell details
    let imageSideLength: CGFloat = 51
    let largeImageSideLength: CGFloat = 150
    
    // components in cell view
    var backgroundViewWithShadow: UIView?
    var titleLabel: UILabel?
    var locationLabel: UILabel?
    var timeLabel: UILabel?
    var contentImageView: UIImageView?
    var itemDescriptionLabel: UILabel?
    var itemTagLabel: UILabel?
    var horizontalTagStack: UIStackView?
    
    // change cell structure everytime celltype is changed
    var cellType: FormattedTableViewCellType = .defaultCell {
        didSet {
            reloadView()
        }
    }
    // change position of tags
    var hasUpperTags: Bool = false {
        didSet {
            reloadView()
        }
    }
    var hasRegularRightDetail: Bool = false {
        didSet {
            reloadView()
        }
    }
    var hasStyledTags: Bool = false {
        didSet {
            reloadView()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func reloadView() {
        if backgroundViewWithShadow != nil { backgroundViewWithShadow!.removeFromSuperview() }
        backgroundViewWithShadow = nil
        setupView()
    }
    
    func setupView() {
        switch (cellType) {
        case FormattedTableViewCellType.defaultCell:
            setupDefaultCellView()
            return
        case FormattedTableViewCellType.detailedCell:
            setupDetailedCellView()
            return
        case FormattedTableViewCellType.hiddenDetailedCell:
            setuphiddenDetailedCellView()
            return
        case FormattedTableViewCellType.leftImageCell:
            setupLeftImageCellView()
            return
        }
    }
    
    func createBackgroundView() {
        backgroundViewWithShadow = UIView()
        
        backgroundViewWithShadow?.backgroundColor = .white
        backgroundViewWithShadow?.layer.shadowColor = UIColor.black.cgColor
        backgroundViewWithShadow?.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        backgroundViewWithShadow?.layer.shadowRadius = 4
        backgroundViewWithShadow?.layer.cornerRadius = 14
        backgroundViewWithShadow?.layer.shadowOpacity = 1
        backgroundViewWithShadow?.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview((backgroundViewWithShadow)!)
        backgroundViewWithShadow?.topAnchor.constraint(equalTo: contentView.topAnchor, constant: yMargin).isActive = true
        backgroundViewWithShadow?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -yMargin).isActive = true
        backgroundViewWithShadow?.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: xMargin).isActive = true
        backgroundViewWithShadow?.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -xMargin).isActive = true
    }
    
    func createFormattedLabel(type: FormattedLabelType, defaultText: String, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 110, height: 30))
        label.text = defaultText
        label.textAlignment = alignment
        
        if type == .title {
            label.textColor = BACKGROUND_COLOR
        } else if type == .paragraph {
            label.numberOfLines = 0
        }
        
        switch type {
        case .majorParagraph:
            label.font = MAJOR_PARAGRAPH_FONT
            break
        case .minorParagraph:
            label.font = MINOR_PARAGRAPH_FONT
            break
        case .paragraph:
            label.font = PARAGRAPH_FONT
            break
        default:
            label.font = TITLE_FONT
            break
        }
        
        return label
    }
    
    func addNewTag(tag: String = "default tag") {
        var view: UIView
        if hasStyledTags {
            view = createTagInView(defaultText: tag)
        } else {
            view = createFormattedLabel(type: .minorParagraph, defaultText: tag, alignment: .center)
        }
        guard let hts = horizontalTagStack else {return}
        hts.insertArrangedSubview(view, at: 0)
    }
    
    func createTagInView(defaultText: String = "default tag") -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 81, height: 22))
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 22).isActive = true
        view.widthAnchor.constraint(equalToConstant: 81).isActive = true
        view.layer.cornerRadius = 7.2
        view.clipsToBounds = true
        
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.startPoint = CGPoint.zero;
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [UIColor(hex: 0x0CB2FF, alpha: 1).cgColor, UIColor(hex: 0x057AFF, alpha: 1).cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        
        itemTagLabel = createFormattedLabel(type: .minorParagraph, defaultText: defaultText, alignment: .center)
        itemTagLabel?.textColor = .white
        itemTagLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(itemTagLabel!)
        itemTagLabel?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        itemTagLabel?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }
}
