//
//  MainViewController.swift
//  SimpleCaro
//
//  Created by Robert Nguyen on 3/9/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import CoreCleanSwiftBase

class MainViewController: BaseCleanViewController {
    
    @IBOutlet weak var lbHeuristic: UILabel!
    @IBOutlet weak var lbThinking: UILabel!
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var difficutySlider: UISlider!
    @IBOutlet weak var segMode: UIView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var shadowStartView: UIView!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var lbSize: UILabel!
    @IBOutlet weak var lbDifficuty: UILabel!
    
    var interactor: MainInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let boardVC = children.first(where: { $0 is BoardViewController }) as? BoardViewController
        interactor = MainInteractor(presenter: MainPresenter(view: self), boardPresenter: BoardPresenter(view: boardVC?.collectionView))
        
        lbSize.text = "\(interactor.boardSize)"
        sizeSlider.value = (Float)(interactor.boardSize)
        lbDifficuty.text = "\(interactor.difficulty)"
        difficutySlider.value = (Float)(interactor.difficulty)
    }
    
    @IBAction func difficutySliderChanged(_ sender: UISlider) {
        shadowStartView.isHidden = false
        lbDifficuty.text = "\(Int(sender.value))"
        interactor.boardSize = Int(sender.value)
    }
    
    @IBAction func segModeChanged(_ sender: UISegmentedControl) {
        shadowStartView.isHidden = false
        difficutySlider.isEnabled = sender.selectedSegmentIndex != 2
    }
    
    @IBAction func onStart(sender: AnyObject) {
        shadowStartView.isHidden = true
        interactor.startGame()
    }
    
    @IBAction func onSizeSliderChanged(_ sender: UISlider) {
        shadowStartView.isHidden = false
        lbSize.text = "\(Int(sender.value))"
        interactor.boardSize = Int(sender.value)
    }
    
    @IBAction func onShowHeuristic(_ sender: UIButton) {
        interactor.gameController?.printDebug()
        lbHeuristic.text = "\(interactor.heuristic)"
    }
    
    override func onError(_ error: Error) {
        let alertVC = UIAlertController(title: "Caro", message: error.localizedDescription, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true)
    }
}

extension MainViewController: MainView {
    func showGameOver(msg: String) {
        let alertVC = UIAlertController(title: "Caro", message: msg, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "New game", style: .default) {
            _ in
            self.interactor.startGame()
        })
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertVC, animated: true)
    }
}

extension MainViewController: ListViewInteractive {
    func didSelect(at indexPath: IndexPath) {
        interactor.place(at: Coordinate(row: indexPath.section, column: indexPath.row))
    }
}
