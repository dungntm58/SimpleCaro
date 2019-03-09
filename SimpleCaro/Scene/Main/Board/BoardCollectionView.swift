//
//  BoardCollectionView.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import CoreCleanSwiftBase

class BoardCollectionView: BaseCleanCollectionView {
    override func createViewSource() -> BaseCleanCollectionView.DataViewSource? {
        let cell = DefaultCellModel(type: .nib(nibName: "Square", bundle: nil))
        let section = DefaultSectionModel(cells: [cell])
        return BoardViewSource(sections: [section], listViewInteractive: self.viewController as? ListViewInteractive, shouldAnimateLoading: false)
    }
}

extension BoardCollectionView: BoardView {
    
}

class BoardViewSource: BaseCleanCollectionViewSource {
    
}
