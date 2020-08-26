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
        
        getLevel()
        
        getBoard()
        
        getPieces()
    }
    
    func getLevel() {
        
        level.number = 1
        level.boardHeight = 8
        level.boardWidth = 4
        let pieceLocationIndex1 = Indexes(x: 2, y: 3)
        let pieceLocationIndex2 = Indexes(x: 3, y: 7)
        level.pieceLocations.append(pieceLocationIndex1)
        level.pieceLocations.append(pieceLocationIndex2)
    }
    
    func getBoard() {
        
        let frameWidth = view.frame.width / 10 * 9
        let frameHeight = view.frame.height / 10 * 9
        let frameX = (view.frame.width - frameWidth) / 2
        let frameY = (view.frame.height - frameHeight) / 2
        let frame = CGRect(x: frameX, y: frameY, width: frameWidth, height: frameHeight)
        board.grid = GridPoints(frame: frame, height: level.boardHeight, width: level.boardWidth).getGrid()
        delegate?.setUpBoard(board: board)
    }
    
    func getPieces() {

        for location in level.pieceLocations {
            
            let piece = Piece()
            piece.indexes = location
            piece.shape = "Square"
            pieces.append(piece)
        }
        delegate?.setUpPiecesView(pieces: pieces)
    }
    
    func movePiece(direction: UISwipeGestureRecognizer.Direction) {
        
        for piece in pieces {
            
            switch direction {
                
            case .up:
                if piece.indexes.y != 0 {
                    piece.indexes.y = piece.indexes.y! - 1
                }
            case .down:
                if piece.indexes.y != board.grid.keys.map({$0.y!}).max(by: { (int1, int2) -> Bool in
                    print("int1 \(int1), int2 \(int2)")
                    return int1 < int2
                }) {
                    piece.indexes.y = piece.indexes.y! + 1
                }
                
            case .left:
                if piece.indexes.x != 0 {

                    piece.indexes.x = piece.indexes.x! - 1
                }
            case .right:
                
                if piece.indexes.x != board.grid.keys.map({$0.x!}).max(by: { (int1, int2) -> Bool in
                    print("int1 \(int1), int2 \(int2)")
                    return int1 < int2
                }) {
                    piece.indexes.x = piece.indexes.x! + 1
                }

            default:
                break
            }
        }
        
        print(pieces.map({$0.indexes}))
        
        delegate?.movePieces(pieces: pieces)
    }
}
