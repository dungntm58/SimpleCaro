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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(attachedView: collectionView)
    }
}
