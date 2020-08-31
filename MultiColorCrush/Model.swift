//
//  Model.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 8/18/20.
//  Copyright © 2020 Jeffery Widroff. All rights reserved.
//

import Foundation
import UIKit

//TODO: After checking if theres something blocking the space, check to see what it is and go accordingly
//TODO: Create walls
//TODO: Give pieces opacity
//TODO: Make like-pieces combine


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
        
        let pieceLocationIndex1 = Indexes(x: 3, y: 7)
        let pieceLocationIndex2 = Indexes(x: 1, y: 7)
        let pieceLocationIndex3 = Indexes(x: 1, y: 4)
        level.number = 1
        level.boardHeight = 9
        level.boardWidth = 4
        level.pieceLocations.append(pieceLocationIndex1)
        level.pieceLocations.append(pieceLocationIndex2)
        level.pieceLocations.append(pieceLocationIndex3)
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
            piece.color = UIColor.blue
            pieces.append(piece)
        }
        delegate?.setUpPiecesView(pieces: pieces)
    }
    
    func isNextSpaceBlocked(direction: UISwipeGestureRecognizer.Direction, indexes: Indexes) -> Bool {
        
        var bool = true

        switch direction {
        case .up:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
            }){
                bool = false
            }
            
        case .down:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! + 1)
            }){
                bool = false
            }
            
        case .left:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! - 1, y: indexes.y)
            }){
                bool = false
            }
            
        case .right:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! + 1, y: indexes.y)
            }){
                bool = false
            }
        default:
            break
        }
        return bool
    }
    
    func getPieceInfo(index: Indexes) -> Piece {
        
        var piece = Piece()
        
        for pieceX in pieces {
            
            if pieceX.indexes == index {
                
                piece = pieceX
                
            }
            
            
        }
        
        
        return piece
    }
    
    func movePiece(direction: UISwipeGestureRecognizer.Direction) {
        
        switch direction {
            
        case .up:
                        
            for piece in pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.y! < piece2.indexes.y!
            }) {
                let spaceIsntBlocked = isNextSpaceBlocked(direction: .up, indexes: piece.indexes)
                let notAtWall = piece.indexes.y != 0
                if notAtWall {
                    if spaceIsntBlocked {
                        piece.indexes.y = piece.indexes.y! - 1
                    } else {
                        
                        let bloackingPiece = getPieceInfo(index: Indexes(x: piece.indexes.x, y: piece.indexes.y! - 1))
                        if bloackingPiece.shape == piece.shape && bloackingPiece.color == piece.color {
                            
                            piece.indexes.y = piece.indexes.y! - 1

                        }
                    }
                }
            }
            delegate?.movePieces(pieces: pieces)

        case .down:
            for piece in pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.y! > piece2.indexes.y!
                
            }) {
                
                let spaceIsntBlocked = isNextSpaceBlocked(direction: .down, indexes: piece.indexes)
                
                let notAtWall = piece.indexes.y != board.grid.keys.map({$0.y!}).max(by: { (int1, int2) -> Bool in
                    print("int1 \(int1), int2 \(int2)")
                    return int1 < int2
                })
                if notAtWall {
                    if spaceIsntBlocked{
                        piece.indexes.y = piece.indexes.y! + 1
                    } else {
                        
                        let bloackingPiece = getPieceInfo(index: Indexes(x: piece.indexes.x, y: piece.indexes.y! + 1))
                        if bloackingPiece.shape == piece.shape && bloackingPiece.color == piece.color {
                            
                            piece.indexes.y = piece.indexes.y! + 1

                        }
                    }
                }
            }
            delegate?.movePieces(pieces: pieces)

        case .left:
            for piece in pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.x! < piece2.indexes.x!
            }) {
                let spaceIsntBlocked = isNextSpaceBlocked(direction: .left, indexes: piece.indexes)
                let notAtWall = piece.indexes.x != 0
                if notAtWall {
                    if spaceIsntBlocked {
                        piece.indexes.x = piece.indexes.x! - 1
                    } else {
                        
                        let bloackingPiece = getPieceInfo(index: Indexes(x: piece.indexes.x! - 1, y: piece.indexes.y))
                        if bloackingPiece.shape == piece.shape && bloackingPiece.color == piece.color {
                            
                            piece.indexes.x = piece.indexes.x! - 1

                        }
                    }
                }
            }
            delegate?.movePieces(pieces: pieces)

        case .right:
            for piece in pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.x! > piece2.indexes.x!
            }) {
                let spaceIsntBlocked = isNextSpaceBlocked(direction: .right, indexes: piece.indexes)
                let notAtWall = piece.indexes.x != board.grid.keys.map({$0.x!}).max(by: { (int1, int2) -> Bool in
                    print("int1 \(int1), int2 \(int2)")
                    return int1 < int2
                })
                if notAtWall {
                    if spaceIsntBlocked {
                        piece.indexes.x = piece.indexes.x! + 1
                    } else {
                        
                        let bloackingPiece = getPieceInfo(index: Indexes(x: piece.indexes.x! + 1, y: piece.indexes.y))
                        if bloackingPiece.shape == piece.shape && bloackingPiece.color == piece.color {
                            
                            piece.indexes.x = piece.indexes.x! + 1

                        }
                    }
                }
            }
            delegate?.movePieces(pieces: pieces)

        default:
            break
        }
    }
}
