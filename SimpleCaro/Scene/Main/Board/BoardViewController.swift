//
//  BoardViewController.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/9/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import CoreCleanSwiftBase

class BoardViewController: BaseCleanViewController {
    
    @IBOutlet weak var collectionView: BoardCollectionView!
    @IBOutlet weak var coverView: UIView!
    
    var interactor: BoardInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(attachedView: collectionView)
        interactor = BoardInteractor(presenter: BoardPresenter(view: collectionView))
    }
}

extension BoardViewController: ListViewInteractive {
    func didSelect(at indexPath: IndexPath) {
        
    }
}
