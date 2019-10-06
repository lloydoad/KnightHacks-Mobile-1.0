//
//  HeaderContentViewModel.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 7/21/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import Foundation

internal class HeaderContentViewModel<T: FilterDataSource & HeaderDataSource & Comparable> {
    
    var observer: ModelObserver?
    
    var fetchedData: [T] = []
    var viewContent: [[T]] = []
    var numberOfSections: Int = 0
    
    func fetchData() {
        viewContent = getViewContent(fetchedData)
        numberOfSections = viewContent.count
        observer?.didFetchModel()
        print(viewContent)
    }
    
    public let defaultAllFilter = FilterNames.all.rawValue
    func filterData(_ name: FilterMenuModel) {
        viewContent = name.name == defaultAllFilter ? getViewContent(fetchedData) : filter(fetchedData, by: name)
        numberOfSections = viewContent.count
        observer?.didFetchModel()
    }
            
    private func filter(_ content: [T], by filter: FilterMenuModel) -> [[T]] {
        let filteredContent = content.filter { $0.filters.contains(filter) }
        return getViewContent(filteredContent)
    }
    
    func getViewContent(_ content: [T]) -> [[T]] {
        
        var results: [[T]] = []
        var list = content
        
        list.sort()
                
        guard let first = list.first else { return results }
        var prevHeader = first.header
        var currentList = [first]
        
        list[1..<list.count].forEach { single in
            if single.header != prevHeader {
                results.append(currentList)
                prevHeader = single.header
                currentList = [single]
            } else {
                currentList.append(single)
            }
        }
        
        results.append(currentList)
        
        return results
    }
}
