//
//  FilterTableHeaderView.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/27/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

internal class FilterTableHeaderView: UIView {
    
    private let nibName: String = "FilterTableHeaderView"
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initView()
    }
    
    private func initView() {
        Bundle.main.loadNibNamed(self.nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
