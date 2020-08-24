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
//    func getGrid(grid: [Indexes: CGPoint])
    func setUpPiecesView(pieces: [Piece])
}


class Model {
    
    var board = Board()
    var pieces = [Piece]()
    var level = Level()
    var delegate: ModelDelegate?
    
    init(){
        
    }
    
    func setUpGame() {
        
        getLevel()
        
        getBoard()
        
        getPieces()
        
//        delegate?.getGrid(grid: board.grid)
    }
    
    func getLevel() {
        
        //Make this useful
        level.number = 1
        level.boardHeight = 8
        level.boardWidth = 4
        let pieceLocationIndex1 = Indexes(x: 2, y: 3)
        let pieceLocationIndex2 = Indexes(x: 3, y: 7)
        level.pieceLocations.append(pieceLocationIndex1)
        level.pieceLocations.append(pieceLocationIndex2)
    }
    
    func getBoard() {
        
        delegate?.setUpBoard(board: board)
        board.grid = GridPoints(frame: board.view.frame, height: level.boardHeight, width: level.boardWidth).getGrid()
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
}
