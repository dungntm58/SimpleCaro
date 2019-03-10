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
        return BoardViewSource(sectionSize: AppPreferences.instance.get(key: .boardSize), listViewInteractive: viewController?.parent as? ListViewInteractive)
    }
}

extension BoardCollectionView: BoardView {
    func showGrid(size: Int) {
        updateListModel(type: .initial, newItems: (0..<size*size).enumerated().map { BoardViewModel.Cell(differenceIdentifier: $0.element, sign: nil, isNew: false) })
    }
}

class BoardViewSource: BaseCleanCollectionViewSource {
    let sectionSize: Int
    
    init(sectionSize: Int, listViewInteractive: ListViewInteractive?) {
        self.sectionSize = sectionSize
        let cell = DefaultCellModel(type: .nib(nibName: "Square", bundle: nil))
        super.init(sections: Array(repeating: DefaultSectionModel(cells: [cell]), count: sectionSize), listViewInteractive: listViewInteractive , shouldAnimateLoading: false)
    }
    
    override func bind(value: CleanListViewModel, to cell: UICollectionViewCell, at indexPath: IndexPath) {
        let cell = cell as! Square
        let value = value as! BoardViewModel.Cell
        
        if let sign = value.sign {
            cell.image.image = UIImage(named: "icon_\(sign.rawValue)")
        }
        else {
            cell.image.image = nil
        }
        
        if value.isNew {
            cell.image.backgroundColor =  #colorLiteral(red: 1, green: 0.5333333333, blue: 0.6745098039, alpha: 0.3041791524)
        }
        else {
            cell.image.backgroundColor = nil
        }
    }
    
    override func objects(in section: SectionModel, at index: Int, onChanged type: ListModelChangeType) -> [CleanListViewModel] {
        guard let cells = models(for: BoardViewModel.Cell.self) else {
            return []
        }
        
        return Array(cells[index*sectionSize..<(index + 1)*sectionSize])
    }
}
