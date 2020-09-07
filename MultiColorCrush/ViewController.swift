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
    var spaceViews = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = Model(view: self.view)
        model.delegate = self
        model.setUpGame()
        addSwipeGestureRecognizer(view: board.view)
    }
    
    func addSwipeGestureRecognizer(view: UIView) {
        
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
    
    func addTapGestureRecognizer(view: UIView) {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        
        
    }
    
    @objc func handleTap(sender:UITapGestureRecognizer) {
        
        let pieceCenter = sender.view?.center
        model.handleTap(center: pieceCenter!)
    
    }
    
    func resetSpaces() {
        
        for space in spaceViews {
            
            space.backgroundColor = .black
        }
        
        
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



//FIX THE PIECES ARE CONNECTED ALREADY
extension ViewController: ModelDelegate {
    
    func animatePiece(piece: Piece) {
        
        UIView.animate(withDuration: 1.0, animations: {
            for spaceView in self.spaceViews {
                
                if spaceView.center == CGPoint(x: self.board.grid[piece.indexes]!.x, y: self.board.grid[piece.indexes]!.y) {
                    
                    spaceView.backgroundColor = .purple
                }
            }
        }) { (true) in
            self.resetSpaces()
        }
    }
    
    
    func movePieces(pieces: [Piece]) {
        
        for piece in pieces {
            
            UIView.animate(withDuration: 0.25) {
                piece.view.center = self.board.grid[piece.indexes]!
            }
        }
    }
    
    func setUpPiecesView(pieces: [Piece]) {
        
        let pieceWidth = self.board.view.frame.width / 100 * 18
        let pieceHeight = self.board.view.frame.width / 100 * 18
        
        for piece in pieces {
            
            let frame = CGRect(x: 0, y: 0, width: pieceWidth, height: pieceHeight)
            piece.view = ShapeView(frame: frame, color: piece.color.cgColor, shape: piece.shape)
            piece.view.center = CGPoint(x: board.grid[piece.indexes]?.x ?? piece.view.center.x, y: board.grid[piece.indexes]?.y ?? piece.view.center.y)
            piece.view.layer.opacity = 1.0
            
//            piece.view.layer.borderColor = UIColor.white.cgColor
//            piece.view.layer.borderWidth = 1.0

//            piece.view.layer.shadowOpacity = 1
//            piece.view.layer.shadowPath = CGPath(rect: piece.view.bounds, transform: nil)
//            piece.view.layer.shadowColor = UIColor.white.cgColor
//            piece.view.layer.shadowOffset = CGSize(width: 1, height: 1)
//            piece.view.layer.shadowRadius = 5

            addTapGestureRecognizer(view: piece.view)
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

        let spaceWidth = self.board.view.frame.width / 100 * 20
        let spaceHeight = self.board.view.frame.width / 100 * 20
        for point in self.board.grid {
                        
            let pointX = point.value.x
            let pointY = point.value.y
            let frame = CGRect(x: pointX, y: pointY, width: spaceWidth, height: spaceHeight)
//            let spaceView = ShapeView(frame: frame, color: UIColor.blue.cgColor, shape: "square")
//            spaceView.backgroundColor = .clear

            let spaceView = UIView(frame: frame)
            spaceView.frame = frame
            spaceView.center = point.value
            spaceView.backgroundColor = .black
            spaceView.layer.borderColor = UIColor.white.cgColor
            spaceView.layer.borderWidth = 2.0
            spaceView.layer.opacity = 0.5
            spaceViews.append(spaceView)
            self.board.view.addSubview(spaceView)
        }
        for wall in self.board.walls {
            
            let frame = CGRect(x: 0, y: 0, width: spaceWidth, height: spaceHeight)

            let wallView = ShapeView(frame: frame, color: UIColor.black.cgColor, shape: "regular")
            
            wallView.center = CGPoint(x: board.grid[wall.indexes]?.x ?? wall.view.center.x, y: board.grid[wall.indexes]?.y ?? wall.view.center.y)

            wallView.backgroundColor = .black
            //append walls
            
            self.board.view.addSubview(wallView)

            
            
//            let spaceWidth = self.board.view.frame.width / 100 * 20
//            let spaceHeight = self.board.view.frame.width / 100 * 20
//            let pointX = point.value.x
//            let pointY = point.value.y
//            let frame = CGRect(x: pointX, y: pointY, width: spaceWidth, height: spaceHeight)
//            //            let spaceView = ShapeView(frame: frame, color: UIColor.blue.cgColor, shape: "square")
//            //            spaceView.backgroundColor = .clear
//
//            let spaceView = UIView(frame: frame)
//            spaceView.frame = frame
//            spaceView.center = point.value
//            spaceView.backgroundColor = .gray
//            spaceView.layer.borderColor = UIColor.white.cgColor
//            spaceView.layer.borderWidth = 2.0
//            spaceViews.append(spaceView)
//            self.board.view.addSubview(spaceView)
            
            
            
            
            
            
        }
        
    }
    
    func pieceWasTapped(piece: Piece) {
                
        
        piece.view.setNeedsDisplay()

        
//        switch piece.shape
//        
//        {
//        case "doubleElbow":
//            
//            for spaceView in spaceViews {
//                
//                if board.grid[piece.indexes] == spaceView.center {
//
//                    piece.view.backgroundColor = .yellow
//                    
//                }
//                
//                
//            }
//            
//        case "elbow":
//            
//            for spaceView in spaceViews {
//                
//                if board.grid[piece.indexes] == spaceView.center {
//
//                    piece.view.setNeedsDisplay()
//                    
//                }
//                
//                
//            }
//            
//            
//            
//            
//            
//        default:
//            break
//        }
        
        
        
//        if piece.shape == "doubleElbow" {
            
//            for spaceView in spaceViews {
//
//                if board.grid[piece.indexes] == spaceView.center {
//
////                    piece.view.removeFromSuperview()
//
//
////                    let newFrame = CGRect(x: 0, y: 0, width: piece.view.frame.width, height: piece.view.frame.height)
//
////                    piece.view = ShapeView(frame: newFrame, color: UIColor.green.cgColor, shape: "elbow")
////                    spaceView.addSubview(newPiece)
//                    piece.view.backgroundColor = .yellow
//
//                }
//
//
//            }
            
            
            
//        }
        
        
        
        
    }
}




