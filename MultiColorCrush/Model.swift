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
        
//        print("gameview \(gameView.frame)")
//
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
        
        
        //TODO: Update this for all directions
        
        for piece in pieces {
            
            switch direction {
            case .up:
                
                //Find the piece
                
                piece.indexes.y = piece.indexes.y! - 1
                
//                pieces.append(piece)
                
            case .down:
                
                piece.indexes.y = piece.indexes.y! + 1
                
            case .left:
                
                piece.indexes.x = piece.indexes.x! - 1
                
            case .right:
                
                
                piece.indexes.x = piece.indexes.x! + 1

                
            default:
                break
            }
            
            
            
        }
        
        delegate?.setUpPiecesView(pieces: pieces)

        
    }
}
