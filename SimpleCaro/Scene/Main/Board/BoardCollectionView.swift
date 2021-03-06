//
//  BoardCollectionView.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/10/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import CoreCleanSwiftBase
import DifferenceKit

class BoardCollectionView: BaseCleanCollectionView {
    private var lastChangedModelIndex: Int?
}

extension BoardCollectionView: BoardView {
    func showGrid(size: Int) {
        lastChangedModelIndex = nil
        let mainViewVC = viewController?.parent as? ListViewInteractive
        viewSource = BoardViewSource(sectionSize: size, listViewInteractive: mainViewVC)
        collectionViewLayout = BoardViewFlowLayout(cellSize: Constant.boardCellSize)
        viewSource?.updateListModel(type: .initial, newItems: (0..<size*size).map { BoardViewModel.Cell(differenceIdentifier: Int($0), sign: nil, isNew: false) })
    }
    
    func updateCell(at coordinate: Coordinate, sign: PlayerSign, boardSize: Int) {
        if let lastChangedIndex = lastChangedModelIndex {
            if let model = viewSource?.models(for: BoardViewModel.Cell.self)?[lastChangedIndex] as? BoardViewModel.Cell {
                let newModel = BoardViewModel.Cell(differenceIdentifier: lastChangedIndex, sign: model.sign, isNew: false)
                viewSource?.updateListModel(type: .replace(at: lastChangedIndex, length: 1), newItems: [newModel])
            }
        }
        let index = coordinate.row * boardSize + coordinate.column
        lastChangedModelIndex = index
        viewSource?.updateListModel(type: .replace(at: index, length: 1), newItems: [BoardViewModel.Cell(differenceIdentifier: index, sign: sign, isNew: true)])
    }
}

class BoardViewSource: BaseCleanCollectionViewSource {
    let sectionSize: Int
    
    init(sectionSize: Int, listViewInteractive: ListViewInteractive?) {
        self.sectionSize = sectionSize
        let cell = DefaultCellModel(type: .nib(nibName: "Square", bundle: nil))
        
        super.init(sections: (0..<sectionSize).map { _ in DefaultSectionModel(cells: [ cell ]) }, listViewInteractive: listViewInteractive , shouldAnimateLoading: false)
    }
    
    override func bind(value: CleanViewModelItem, to cell: UICollectionViewCell, at indexPath: IndexPath) {
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
    
    override func objects(in section: SectionModel, at index: Int, onChanged type: ListModelChangeType) -> [AnyDifferentiable] {
        guard let cells = models(for: BoardViewModel.Cell.self) else {
            return []
        }
        
        return Array(cells[index*sectionSize..<(index + 1)*sectionSize]).compactMap { $0.toAnyDifferentiable() }
    }
}

class BoardViewFlowLayout: UICollectionViewLayout {
    var contentSize: CGSize = .zero
    let cellSize: CGFloat
    var cellAttrsDictionary: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    
    init(cellSize: CGFloat) {
        self.cellSize = cellSize
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.cellSize = Constant.boardCellSize
        super.init(coder: aDecoder)
    }
    
    override var collectionViewContentSize: CGSize {
        return self.contentSize
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }
    
    override func prepare() {
        guard let collectionView = self.collectionView else {
            return
        }
        
        // Update content size.
        let contentWidth = max(CGFloat(collectionView.numberOfItems(inSection: 0)) * self.cellSize, collectionView.bounds.width)
        let contentHeight = max(CGFloat(collectionView.numberOfSections) * self.cellSize, collectionView.bounds.height)
        
        self.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        let cellSize = max(collectionView.bounds.width / CGFloat(collectionView.numberOfItems(inSection: 0)), Constant.boardCellSize)
        
        let numberOfSections = collectionView.numberOfSections
        
        //Configure size for earch cell
        for section in 0..<numberOfSections {
            let numberOfItems = collectionView.numberOfItems(inSection: section)
            
            // Cycle through each item in the section.
            for item in 0..<numberOfItems {
                
                // Build the UICollectionVieLayoutAttributes for the cell.
                let cellIndex = IndexPath(row: item, section: section)
                let xPos = CGFloat(item) * cellSize
                let yPos = CGFloat(section) * cellSize
                
                let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndex)
                cellAttributes.frame = CGRect(x: xPos, y: yPos, width: cellSize, height: cellSize)
                
                // Save the attributes.
                cellAttrsDictionary[cellIndex] = cellAttributes
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // Create an array to hold all elements found in our current view.
        // Check each element to see if it should be returned.
        // Return list of elements.
        return cellAttrsDictionary.values.filter { rect.intersects($0.frame) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttrsDictionary[indexPath]
    }
}
