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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        lbSize.text = "\(AppPreferences.instance.get(key: .boardSize))"
        sizeSlider.value = (Float)(AppPreferences.instance.get(key: .boardSize))
        lbDifficuty.text = "\(AppPreferences.instance.get(key: .difficulty))"
        difficutySlider.value = (Float)(AppPreferences.instance.get(key: .difficulty))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func difficutySliderChanged(_ sender: UISlider) {
        shadowStartView.isHidden = false
        lbDifficuty.text = "\(sender.value)"
        AppPreferences.instance.set(Int(sender.value), forKey: .difficulty)
    }
    
    @IBAction func segModeChanged(_ sender: UISegmentedControl) {
        shadowStartView.isHidden = false
        difficutySlider.isEnabled = sender.selectedSegmentIndex != 2
//        switch sender.selectedSegmentIndex {
//        case 0:
//            player1 = Human(piece: "x")
//            player2 = Bot(piece: "o")
//            break
//        case 1:
//            player1 = Bot(piece: "x")
//            player2 = Human(piece: "o")
//            break
//        default:
//            player1 = Human(piece: "x")
//            player2 = Human(piece: "o")
//            break
//        }
    }
    
    @IBAction func onStart(sender: AnyObject) {
//        let boardVC = BoardViewController(nibName: "BoardViewController", bundle: nil)
//        boardVC.view.frame = boardView.bounds
//        boardView.addSubview(boardVC.view)
//        boardView.bringSubviewToFront(shadowStartView)
//        self.addChildViewController(boardVC)
//        game = Game(player1: player1, player2: player2, size: SIZE_BOARD)
        
        shadowStartView.isHidden = true
//        if player1 is Bot {
//            let move = (player1 as! Bot).choseMoveByAI(game.board, lastMove: nil)
//            //game.board.lastMove = move
//            game.board.makeMove(player1.piece, row: move.row, col: move.col)
//            game.isTurnPlayer1 = !game.isTurnPlayer1
//            boardVC.collectionSquare.reloadData()
//        }
    }
    
    @IBAction func onSizeSliderChanged(_ sender: UISlider) {
        shadowStartView.isHidden = false
        lbSize.text = "\(sender.value)"
        AppPreferences.instance.set(Int(sender.value), forKey: .boardSize)
    }
    
    @IBAction func onShowHeuristic(_ sender: UIButton) {
//        lbHeuristic.text = "\(Bot.heuristic("x", board: game.board)) " + "\(Bot.heuristic("o", board: game.board))"
//        game.board.printBoard()
    }
}

