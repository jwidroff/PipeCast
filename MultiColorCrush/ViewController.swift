//
//  ViewController.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 8/10/20.
//  Copyright © 2020 Jeffery Widroff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var board = Board()
    var dotView = Piece()
    var model = Model()
    var pieces = [Piece]()
    var squareViews = [ShapeView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = Model(view: self.view)

        model.delegate = self

        model.setUpGame()
                        
        addGestureRecognizer(view: board.view)
        
    }

    func addGamePiece() {
        
        //TODO: Up to this. Fill in the Pieces other properties
        
        let piece = Piece()
        let pieceWidth = board.view.frame.width / 100 * 25
        let pieceHeight = board.view.frame.width / 100 * 25
        let point = board.grid[Indexes(x: 1, y: 1)]
        let frame = CGRect(x: 0, y: 0, width: pieceWidth, height: pieceHeight)
        piece.view = ShapeView(frame: frame, color: UIColor.black.cgColor, shape: "cross")
        piece.view.frame = frame
        piece.view.center = point ?? CGPoint(x: 100, y: 100)
        piece.view.backgroundColor = .green
        pieces.append(piece)
        board.view.addSubview(piece.view)
    }
    
    func addGestureRecognizer(view: UIView) {
        
        var upSwipe = UISwipeGestureRecognizer()
        var downSwipe = UISwipeGestureRecognizer()
        var rightSwipe = UISwipeGestureRecognizer()
        var leftSwipe = UISwipeGestureRecognizer()
        upSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        downSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    @objc func handleSwipe(sender:UISwipeGestureRecognizer) {
        
        switch sender.direction {
            
        case .up:
            model.movePiece(direction: sender.direction)
            
        case .down:
            model.movePiece(direction: sender.direction)

        case .right:
            model.movePiece(direction: sender.direction)

        case .left:
            model.movePiece(direction: sender.direction)

        default:
            break
        }
    }
}


extension ViewController: ModelDelegate {
    
    func movePieces(pieces: [Piece]) {
        
        for piece in pieces {
            
            UIView.animate(withDuration: 1.0) {
                piece.view.center = self.board.grid[piece.indexes]!
            }
        }
    }
    
    func setUpPiecesView(pieces: [Piece]) {
        
        for piece in self.pieces {
            
            piece.view.removeFromSuperview()
        }
        
        for piece in pieces {
            
            let frame = CGRect(x: 0, y: 0, width: 25, height: 25)
            piece.view = ShapeView(frame: frame, color: UIColor.red.cgColor, shape: "cross")
            piece.view.center = CGPoint(x: board.grid[piece.indexes]?.x ?? piece.view.center.x, y: board.grid[piece.indexes]?.y ?? piece.view.center.y)
            self.pieces.append(piece)
            board.view.addSubview(piece.view)
        }
    }
    
    func setUpBoard(board: Board) {
                
        let frameWidth = view.frame.width / 10 * 9
        let frameHeight = view.frame.height / 10 * 9
        let frameX = (view.frame.width - frameWidth) / 2
        let frameY = (view.frame.height - frameHeight) / 2
        let frame = CGRect(x: frameX, y: frameY, width: frameWidth, height: frameHeight)
        self.board = board
        self.board.view.frame = frame
        self.board.view.backgroundColor = .black
        view.addSubview(self.board.view)

        for point in self.board.grid {
                        
            let spaceWidth = self.board.view.frame.width / 100 * 25
            let spaceHeight = self.board.view.frame.width / 100 * 25
            let pointX = point.value.x
            let pointY = point.value.y
            let frame = CGRect(x: pointX, y: pointY, width: spaceWidth, height: spaceHeight)
            let spaceView = ShapeView(frame: frame, color: UIColor.blue.cgColor, shape: "square")
            spaceView.frame = frame
            spaceView.center = point.value
            spaceView.backgroundColor = .clear
            self.board.view.addSubview(spaceView)// as UIView)
        }
    }
}




