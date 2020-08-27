//
//  Model.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 8/18/20.
//  Copyright © 2020 Jeffery Widroff. All rights reserved.
//

import Foundation
import UIKit


protocol ModelDelegate {
    func setUpBoard(board: Board)
    func setUpPiecesView(pieces: [Piece])
    func movePieces(pieces: [Piece])
}


class Model {
    
    var board = Board()
    var pieces = [Piece]()
    var level = Level()
    var delegate: ModelDelegate?
    var view = UIView()
    
    init(){
        
    }
    
    init(view: UIView){
        self.view = view
    }
    
    func setUpGame() {
        
        setLevel()
        
        setBoard()
        
        setPieces()
    }
    
    func setLevel() {
        
        level.number = 1
        level.boardHeight = 9
        level.boardWidth = 4
        let pieceLocationIndex1 = Indexes(x: 3, y: 3)
        let pieceLocationIndex2 = Indexes(x: 3, y: 7)
        level.pieceLocations.append(pieceLocationIndex1)
        level.pieceLocations.append(pieceLocationIndex2)
    }
    
    func setBoard() {
        
        let frameWidth = view.frame.width / 10 * 9
        let frameHeight = view.frame.height / 10 * 9
        let frameX = (view.frame.width - frameWidth) / 2
        let frameY = (view.frame.height - frameHeight) / 2
        let frame = CGRect(x: frameX, y: frameY, width: frameWidth, height: frameHeight)
        board.grid = GridPoints(frame: frame, height: level.boardHeight, width: level.boardWidth).getGrid()
        delegate?.setUpBoard(board: board)
    }
    
    func setPieces() {
        
        for location in level.pieceLocations {
            
            let piece = Piece()
            piece.indexes = location
            piece.shape = "cross"
            pieces.append(piece)
        }
        delegate?.setUpPiecesView(pieces: pieces)
    }
    
    func isNextSpaceBlocked(direction: UISwipeGestureRecognizer.Direction, indexes: Indexes) -> Bool {

        var bool = false
        
        if pieces.contains(where: { (piece) -> Bool in
            piece.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
        }){
            bool = true
            
        }
        return bool
    }
    
    func movePiece(direction: UISwipeGestureRecognizer.Direction) {
        
        switch direction {
            
            
            
            
        case .up:
            
            //TODO: Sort the pieces
            
            for piece in pieces.sorted(by: { (piece1, piece2) -> Bool in
                
                piece1.indexes.y! < piece2.indexes.y!
                
                
            }) {
                
//                Check to make sure there's no piece there already
//                If there is, what kind of piece is it?
//                Check to make sure there isnt a wall there
//                Check to make sure there isnt a block there
                
                
                
                let spaceIsBlocked = isNextSpaceBlocked(direction: .up, indexes: piece.indexes)
                
                print("spaceIsBlocked \(spaceIsBlocked)")

                
                if piece.indexes.y != 0 {
                    piece.indexes.y = piece.indexes.y! - 1
                }
            }
            delegate?.movePieces(pieces: pieces)

        case .down:
            for piece in pieces {
                
                if piece.indexes.y != board.grid.keys.map({$0.y!}).max(by: { (int1, int2) -> Bool in
                    print("int1 \(int1), int2 \(int2)")
                    return int1 < int2
                }) {
                    piece.indexes.y = piece.indexes.y! + 1
                }
            }
            delegate?.movePieces(pieces: pieces)

        case .left:
            for piece in pieces {
                
                if piece.indexes.x != 0 {
                    
                    piece.indexes.x = piece.indexes.x! - 1
                }
            }
            delegate?.movePieces(pieces: pieces)

        case .right:
            for piece in pieces {
                
                if piece.indexes.x != board.grid.keys.map({$0.x!}).max(by: { (int1, int2) -> Bool in
                    print("int1 \(int1), int2 \(int2)")
                    return int1 < int2
                }) {
                    piece.indexes.x = piece.indexes.x! + 1
                }
            }
            delegate?.movePieces(pieces: pieces)

        default:
            break
        }
        
        
        
//
//
//        for piece in pieces {
//
//            switch direction {
//
//            case .up:
//
//                //Check to make sure there's no piece there already
//                    //If there is, what kind of piece is it?
//                //Check to make sure there isnt a wall there
//                //Check to make sure there isnt a block there
//
//
//
//
//
//
//
//                if piece.indexes.y != 0 {
//                    piece.indexes.y = piece.indexes.y! - 1
//                }
//            case .down:
//                if piece.indexes.y != board.grid.keys.map({$0.y!}).max(by: { (int1, int2) -> Bool in
//                    print("int1 \(int1), int2 \(int2)")
//                    return int1 < int2
//                }) {
//                    piece.indexes.y = piece.indexes.y! + 1
//                }
//
//            case .left:
//                if piece.indexes.x != 0 {
//
//                    piece.indexes.x = piece.indexes.x! - 1
//                }
//            case .right:
//
//                if piece.indexes.x != board.grid.keys.map({$0.x!}).max(by: { (int1, int2) -> Bool in
//                    print("int1 \(int1), int2 \(int2)")
//                    return int1 < int2
//                }) {
//                    piece.indexes.x = piece.indexes.x! + 1
//                }
//
//            default:
//                break
//            }
//        }
//
//        print(pieces.map({$0.indexes}))
//
//        delegate?.movePieces(pieces: pieces)
    }
    
    
    
    
    
    
}
