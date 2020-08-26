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
        let pieceWidth = board.view.frame.width / 100 * 15
        let pieceHeight = board.view.frame.width / 100 * 15
        let point = board.grid[Indexes(x: 1, y: 1)]
        let frame = CGRect(x: 0, y: 0, width: pieceWidth, height: pieceHeight)
        piece.view = ShapeView(frame: frame, color: UIColor.black.cgColor, shape: "circle")
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
    
    func setUpPiecesView(pieces: [Piece]) {
        
        for piece in self.pieces {
            
            piece.view.removeFromSuperview()
        }
        
        for piece in pieces {
            
            let frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            piece.view = ShapeView(frame: frame, color: UIColor.black.cgColor, shape: "circle")
            piece.view.center = CGPoint(x: board.grid[piece.indexes]?.x ?? 0, y: board.grid[piece.indexes]?.y ?? 0)
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
        self.board.view.backgroundColor = .blue
        view.addSubview(self.board.view)
        
        for point in self.board.grid {
                        
            let dotWidth = self.board.view.frame.width / 100 * 10
            let dotHeight = self.board.view.frame.width / 100 * 10
            let pointX = point.value.x
            
            let pointY = point.value.y
            let frame = CGRect(x: pointX, y: pointY, width: dotWidth, height: dotHeight)
            let dotView = UIView(frame: frame)
            dotView.frame = frame
            dotView.center = point.value
//            dotView.backgroundColor = .black
            self.board.view.addSubview(dotView)
        }
        for point in self.board.grid {
                        
            let dotWidth = self.board.view.frame.width / 100 * 20
            let dotHeight = self.board.view.frame.width / 100 * 20
            let pointX = point.value.x
            let pointY = point.value.y
            let frame = CGRect(x: pointX, y: pointY, width: dotWidth, height: dotHeight)
            let dotView = UIView(frame: frame)
            dotView.frame = frame
            dotView.center = point.value
            dotView.backgroundColor = .green
            self.board.view.addSubview(dotView)
        }
    }
}




