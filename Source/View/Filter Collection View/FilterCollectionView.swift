//
//  FilterCollectionView.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/23/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit

/**
 This protocol provides the datasource for filter collection view cells
 */
public protocol FilterCollectionViewDataSource {
    var filters: [FilterMenuModel] { get set }
}

/**
 This protocol only provides menu tapped responses. For more control, overriding the delegate with a UICollectionViewDelegate is recommended.
 */
public protocol FilterCollectionViewDelegate {
    func didSelectFilter(filter: FilterMenuModel)
}

/**
 A filter menu view for sorting and sectioning large lists of data
 - Requires the implementation of FilterCollectionViewDataSource to set filter button contents
 - Filter menu functionality can be extended either through FilterCollectionViewDelegate or UICollectionViewDelegate for more user-defined functions
 */
public class FilterCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public static let nibName: String = "FilterCollectionView"
    
    public static let minimumRequiredHeight: CGFloat = 115
    public static let minimumRequiredWidth: CGFloat = 85
    public static let minimumCellFrame: CGRect = CGRect(
        x: 0, y: 0, width: FilterCollectionView.minimumRequiredWidth, height: FilterCollectionView.minimumRequiredHeight
    )
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    public var dataSource: FilterCollectionViewDataSource?
    public var delegate: FilterCollectionViewDelegate?
    
    public var shouldStartLoadingAnimation: Bool? {
        didSet {
            guard shouldStartLoadingAnimation == true  else { return }
            guard let datasource = dataSource else { return }
            collectionView.selectItem(at: IndexPath(row: datasource.filters.count - 1, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
        self.initCollectionView()
        collectionView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initView()
        self.initCollectionView()
        collectionView.delegate = self
    }
    
    private func initView() {
        Bundle.main.loadNibNamed(FilterCollectionView.nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func initCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: FilterCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        collectionView.reloadData()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        delegate?.didSelectFilter(filter: dataSource?.filters[indexPath.row] ?? FilterMenuModel(name: "nil"))
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: FilterCollectionView.minimumRequiredWidth, height: FilterCollectionView.minimumRequiredHeight)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.filters.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as? FilterCollectionViewCell, indexPath.row < dataSource?.filters.count ?? 0 else {
            return UICollectionViewCell(frame: FilterCollectionView.minimumCellFrame)
        }
        cell.model = dataSource?.filters[indexPath.row]
        return cell
    }
}
