//
//  DynamicTableViewCell.swift
//  KnightHacks
//
//  Created by KnightHacks on 9/16/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

class DynamicTableViewCell: UITableViewCell {
    static let identifier: String = "DynamicTableViewCell"
    
    // margins, borders and sizes
    var xMargin: CGFloat = 23
    var yMargin: CGFloat = 8
    var backgroundInnerMargin: CGFloat = 15
    var hiddenDetailMaximizeButtonLength: CGFloat = 27
    // cell image sizes
    var imageSideLength: CGFloat = 51
    var largeImageSideLength: CGFloat = 150
    
    // components in cell view
    var backgroundViewWithShadow: UIView?
    var titleLabel: UILabel?
    var locationLabel: UILabel?
    var timeLabel: UILabel?
    var contentImageView: UIImageView?
    var itemDescriptionLabel: UILabel?
    var itemTagLabel: UILabel?
    var horizontalTagStack: UIStackView?
    var showMoreButton: UIButton?
    
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
    // changes time/side subtitle to a bold or regular font
    var isTimeStampMinimized: Bool = false {
        didSet {
            reloadView()
        }
    }
    // has a tag with view background
    var hasStyledTags: Bool = false {
        didSet {
            reloadView()
        }
    }
    // showing hidden details of hidden detail cell
    var isShowingDetails: Bool = false {
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
        backgroundViewWithShadow?.layer.shadowColor = UIColor.gray.cgColor
        backgroundViewWithShadow?.layer.shadowOffset = CGSize(width: 0.2, height: 0.3)
        backgroundViewWithShadow?.layer.shadowRadius = 0.8
        backgroundViewWithShadow?.layer.cornerRadius = 14
        backgroundViewWithShadow?.layer.shadowOpacity = 1
        backgroundViewWithShadow?.translatesAutoresizingMaskIntoConstraints = false
        
        let insets = UIEdgeInsets(top: yMargin, left: yMargin, bottom: -yMargin, right: -yMargin)
        boundEdges(of: backgroundViewWithShadow!, to: self.contentView, with: insets)
    }
    
    func addNewTag(tag: String = "default tag") {
        var view: UIView
        
        guard let hts = horizontalTagStack else {return}
        if hasStyledTags {
            view = createTagInView(defaultText: tag)
        } else {
            let label = createFormattedLabel(type: .minorParagraph, defaultText: tag, alignment: .center) as UILabel
            label.textColor = DARK_GREEN_COLOR
            view = label
        }
        hts.insertArrangedSubview(view, at: 0)
    }
    
    func createTagInView(defaultText: String = "default tag") -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 81, height: 22))
        view.layer.cornerRadius = 7.2
        view.clipsToBounds = true
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint.zero;
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [LIGHT_BLUE_SHADE_COLOR.cgColor, DARK_BLUE_SHADE_COLOR.cgColor]
        
        itemTagLabel = createFormattedLabel(type: .minorParagraph, defaultText: defaultText, alignment: .center)
        itemTagLabel?.textColor = .white
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 22).isActive = true
        view.widthAnchor.constraint(equalToConstant: 81).isActive = true
        gradient.frame = view.frame
        view.layer.insertSublayer(gradient, at: 0)

        view.addSubview(itemTagLabel!)
        itemTagLabel?.translatesAutoresizingMaskIntoConstraints = false
        itemTagLabel?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        itemTagLabel?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }
}
