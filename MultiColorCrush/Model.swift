//
//  Model.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 8/18/20.
//  Copyright © 2020 Jeffery Widroff. All rights reserved.
//

import Foundation
import UIKit



//TODO: Create pieces that add pieces
//TODO: Create pieces that consume pieces

//TODO: Possibly make it that when the same EXACT pieces push into eachother, they combine

//TODO: Make slippery tiles
//TODO: Make the possibility for more balls
//TODO: Make the possibility for ball color-changing pieces
//TODO: change the control of the color of the pieces, entrances, exits, walls... etc to the Model
//TODO: Make sure that all piece characteristics are chosen in the model (ultimately by the level)
//TODO: Give pieces the ability to rotate
//TODO: Make a piece that rotates pieces
//TODO: Make all of the pieces move together once the start button is pressed
//TODO: make a pivot line on the pivot pieces
//TODO: Need to turn off gesture recognizers when the ball is moving
//TODO: Make the pieces switch if the ball passes it
//TODO: Make a piece that changes the balls color
//TODO: Make it that the variables of each piece can be set on their own and create a level model
//TODO: Make it that the pieces switch (if they have a switch) after the ball passes
//TODO: Make it that the ball follows the curve better

//TODO: Make it that the entrances cant open next to a wall
//TODO: Add place that pieces get added from (in higher levels)
//TODO: Make a retry button



//TODO: Add number of moves left
//TODO: Make the text box for the entrance lower when the ball initially moves


protocol ModelDelegate {
    func setUpGame(board: Board)
    func setUpPiecesView()
    func movePieces()
    func animatePiece(piece: Piece)
    func pieceWasTapped(piece: Piece)
    func moveBallView(ball: Ball, piece: Piece, startSide: String, endSide: String)
}

class Model {
    
    var board = Board()
    var level = Level()
    var delegate: ModelDelegate?
    
    init(){
        
    }
    
    init(view: UIView){
        self.board.view = view
    }
    
    func setUpGame() {
        
        setLevel()
        setBoard()
        setPieces()
    }
    
    func setLevel() {
        
//        let pieceLocationIndex1 = Indexes(x: 3, y: 7)
//        let pieceLocationIndex2 = Indexes(x: 1, y: 7)
//        let pieceLocationIndex3 = Indexes(x: 1, y: 4)
//        level.pieceLocations.append(pieceLocationIndex1)
//        level.pieceLocations.append(pieceLocationIndex2)
//        level.pieceLocations.append(pieceLocationIndex3)
        
        level.number = 1
        level.boardHeight = 10
        level.boardWidth = 5
        level.numberOfPieces = 20
    }
    
    func setBoard() {
        
        setupEntrances()
        setupExits()
        setupWalls()
        setupBalls()
        delegate?.setUpGame(board: board)
    }
    
    func setupEntrances() {
        
        for _ in 1...1 {
            
            let entrance = Entrance()
            setPieceIndex(piece: entrance)
            entrance.isLocked = false
            entrance.opening = "top"
            board.pieces.append(entrance)
        }
    }

    func setupExits() {
        
        for _ in 1...1 {
            
            let exit = Exit()
            setPieceIndex(piece: exit)
            exit.isLocked = false
            exit.opening = "bottom"
            board.pieces.append(exit)
        }
    }
    
    func setupWalls() {
        
        for _ in 0...2 {

            let wall = Wall()
            setPieceIndex(piece: wall)
            wall.isLocked = false
            board.pieces.append(wall)
        }
    }
    
    func setupBalls() {
        
        for piece in board.pieces {
            
            if piece is Entrance {
                
                let ball = Ball()
                ball.indexes = piece.indexes
                board.balls.append(ball)
            }
        }
        board.balls = board.balls
    }
    
    func setPieces() {
        
        for _ in 0..<level.numberOfPieces {
            
            let piece = Piece()
            setPieceIndex(piece: piece)
            setPieceShape(piece: piece)
            setPieceColor(piece: piece)
            setPieceSwitches(piece: piece)
            setPieceSides(piece: piece)
            board.pieces.append(piece)
        }
        delegate?.setUpPiecesView()
    }
    
    func setPieceLock(piece: Piece) {
        
        if piece.isLocked {
            
            
            
            
        }
    }
    
    func setPieceSides(piece: Piece) {
        
        //MARK: Perhaps this should include the entrances and exits.
        
        switch piece.shape {
            
        case .elbow:
            
            switch piece.version {

            case 1:
                
                piece.side.top.opening.isOpen = true
                piece.side.left.opening.isOpen = true
                piece.side.top.closing.isOpen = true
                piece.side.left.closing.isOpen = true
                
                piece.side.top.exitSide = "left"
                piece.side.left.exitSide = "top"
                
            case 2:
                
                piece.side.bottom.opening.isOpen = true
                piece.side.left.opening.isOpen = true
                piece.side.bottom.closing.isOpen = true
                piece.side.left.closing.isOpen = true
                
                piece.side.bottom.exitSide = "left"
                piece.side.left.exitSide = "bottom"
                
            case 3:
                
                piece.side.bottom.opening.isOpen = true
                piece.side.right.opening.isOpen = true
                piece.side.bottom.closing.isOpen = true
                piece.side.right.closing.isOpen = true
                
                piece.side.bottom.exitSide = "right"
                piece.side.right.exitSide = "bottom"
                
            case 4:
                
                piece.side.top.opening.isOpen = true
                piece.side.right.opening.isOpen = true
                piece.side.top.closing.isOpen = true
                piece.side.right.closing.isOpen = true
                
                piece.side.top.exitSide = "right"
                piece.side.right.exitSide = "top"
                
            default:
                break
            }
            
        case .doubleElbow:
            
            piece.side.top.opening.isOpen = true
            piece.side.top.closing.isOpen = true
            piece.side.right.opening.isOpen = true
            piece.side.right.closing.isOpen = true
            piece.side.left.opening.isOpen = true
            piece.side.left.closing.isOpen = false
            
            piece.side.top.exitSide = "right"
            piece.side.right.exitSide = "top"
            
        case .quadBox:
            
            piece.side.top.opening.isOpen = true
            piece.side.bottom.opening.isOpen = true
            piece.side.left.opening.isOpen = true
            piece.side.right.opening.isOpen = true
            piece.side.top.closing.isOpen = true
            piece.side.bottom.closing.isOpen = true
            piece.side.left.closing.isOpen = true
            piece.side.right.closing.isOpen = true
            
            piece.side.top.exitSide = "left"
            piece.side.left.exitSide = "top"
            piece.side.bottom.exitSide = "right"
            piece.side.right.exitSide = "bottom"
            
        case .cross:
            
            piece.side.top.opening.isOpen = true
            piece.side.bottom.opening.isOpen = true
            piece.side.left.opening.isOpen = true
            piece.side.right.opening.isOpen = true
            piece.side.left.closing.isOpen = true
            piece.side.right.closing.isOpen = true
            
            piece.side.right.exitSide = "left"
            piece.side.left.exitSide = "right"
            
        case .diagElbow:
            
            piece.side.top.opening.isOpen = true
            piece.side.bottom.opening.isOpen = true
            piece.side.left.opening.isOpen = true
            piece.side.right.opening.isOpen = true
            piece.side.top.closing.isOpen = true
            piece.side.bottom.closing.isOpen = true
            piece.side.left.closing.isOpen = true
            piece.side.right.closing.isOpen = true
            
            switch piece.version {
            
            case 1, 3:
                
                piece.side.right.exitSide = "top"
                piece.side.left.exitSide = "bottom"
                piece.side.top.exitSide = "right"
                piece.side.bottom.exitSide = "left"
                
            case 2, 4:
                
                piece.side.left.exitSide = "top"
                piece.side.right.exitSide = "bottom"
                piece.side.bottom.exitSide = "right"
                piece.side.top.exitSide = "left"
                
            default:
                break
            }
            
        case .sword:
            
            //TODO: Finish this
            print("TODO - Set this")
//            piece.side.top.opening.isOpen = true
//            piece.side.bottom.opening.isOpen = true
//            piece.side.left.opening.isOpen = true
//            piece.side.right.opening.isOpen = true
            
        default:
            break
        }
    }
    
    func setPieceSwitches(piece: Piece) {
        
        switch piece.shape {
        
        case .elbow:
            piece.switches = 2
            piece.currentSwitch = 1
            
        case .doubleElbow:
            
           piece.switches = 2
           piece.currentSwitch = 1
            
        case .diagElbow:
            
            piece.switches = 2
            piece.currentSwitch = 1
            
        case .quadBox:
            
            piece.switches = 2
            piece.currentSwitch = 1
            
        case .sword:
            
            piece.switches = 3
            piece.currentSwitch = 1
            
        case .cross:
            
            piece.switches = 2
            piece.currentSwitch = 1
            
        default:
            break
        }
    }
    
    func setPieceIndex(piece: Piece) {
        
        let index = Indexes(x: Int(arc4random_uniform(UInt32(level.boardWidth))), y: Int(arc4random_uniform(UInt32(level.boardHeight))))
        
        // This is to make sure that the pieces dont start on 1) another piece 2) an entrance 3) an exit 4) a wall
        if board.pieces.contains(where: { (pieceX) -> Bool in
            pieceX.indexes == index
        }){
            setPieceIndex(piece: piece)
        } else {
            piece.indexes = index
        }
    }
    
    func setPieceShape(piece: Piece) {
        
        let version = Int(arc4random_uniform(UInt32(4))) + 1
        piece.version = version
        let randomShapes:[Shape] = [.cross, .elbow, .diagElbow]// .doubleElbow, .quadBox, .diagElbow]//, "sword"]
        piece.shape = randomShapes[Int(arc4random_uniform(UInt32(randomShapes.count)))]
    }
    
    func setPieceColor(piece: Piece) {
        let randomColors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.white, UIColor.purple, UIColor.cyan, UIColor.yellow, UIColor.orange]
        piece.color = randomColors[Int(arc4random_uniform(UInt32(randomColors.count)))]
    }
    
    func isNextSpaceBlocked(direction: UISwipeGestureRecognizer.Direction, indexes: Indexes) -> Bool {
        
        var bool = true

        switch direction {
        case .up:
            if board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
            }){
                bool = false
            }
            
        case .down:
            if board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! + 1)
            }){
                bool = false
            }
            
        case .left:
            if board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! - 1, y: indexes.y)
            }){
                bool = false
            }
            
        case .right:
            if board.pieces.contains(where: { (piece) -> Bool in
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
        
        for pieceX in board.pieces {
            
            if pieceX.indexes == index {
                
                piece = pieceX
                
                print("piece found index = \(piece.indexes)")
            }
        }
        return piece
    }
    
    func movePiece(direction: UISwipeGestureRecognizer.Direction) {
        
        switch direction {
            
        case .up:
                        
            for piece in board.pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.y! < piece2.indexes.y!
            }).filter({ (piece) -> Bool in
                piece.isLocked
            }) {
                let spaceIsntBlocked = isNextSpaceBlocked(direction: .up, indexes: piece.indexes)
                let notAtWall = piece.indexes.y != 0
                if notAtWall {
                    if spaceIsntBlocked {
                        piece.indexes.y = piece.indexes.y! - 1
                    }
                }
            }
            delegate?.movePieces()

        case .down:
            for piece in board.pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.y! > piece2.indexes.y!
                
            }).filter({ (piece) -> Bool in
                piece.isLocked
            })  {
                
                let spaceIsntBlocked = isNextSpaceBlocked(direction: .down, indexes: piece.indexes)
                
                let notAtWall = piece.indexes.y != board.grid.keys.map({$0.y!}).max(by: { (int1, int2) -> Bool in
                    return int1 < int2
                })
                if notAtWall {
                    if spaceIsntBlocked{
                        piece.indexes.y = piece.indexes.y! + 1
                    }
                }
            }
            delegate?.movePieces()

        case .left:
            for piece in board.pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.x! < piece2.indexes.x!
            }).filter({ (piece) -> Bool in
                piece.isLocked
            })  {
                let spaceIsntBlocked = isNextSpaceBlocked(direction: .left, indexes: piece.indexes)
                let notAtWall = piece.indexes.x != 0
                if notAtWall {
                    if spaceIsntBlocked {
                        piece.indexes.x = piece.indexes.x! - 1
                    }
                }
            }
            delegate?.movePieces()

        case .right:
            for piece in board.pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.x! > piece2.indexes.x!
            }).filter({ (piece) -> Bool in
                piece.isLocked
            })  {
                let spaceIsntBlocked = isNextSpaceBlocked(direction: .right, indexes: piece.indexes)
                let notAtWall = piece.indexes.x != board.grid.keys.map({$0.x!}).max(by: { (int1, int2) -> Bool in
                    return int1 < int2
                })
                if notAtWall {
                    if spaceIsntBlocked {
                        piece.indexes.x = piece.indexes.x! + 1
                    }
                }
            }
            delegate?.movePieces()

        default:
            break
        }
    }
        
    func moveBall(ball: Ball, startSide: String) {
        
        switch startSide {
        
        case "unmoved":
            
            let piece = getPieceInfo(index: ball.indexes) as! Entrance
            let startSide = "center"
            let endSide = piece.opening
            delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
            return
        
        case "top":
            
            let piece = getPieceInfo(index: ball.indexes)
            let startSide = "top"
            if let endSide = piece.side.top.exitSide {
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                }
            } else {
                print("crashed into a wall, or no track in place")
            }
            return
            
        case "bottom":
            
            let piece = getPieceInfo(index: ball.indexes)
            let startSide = "bottom"
            if let endSide = piece.side.bottom.exitSide {
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                }
            } else {
                print("crashed into a wall, or no track in place")
            }
            return

            
        case "left":
            
            let piece = getPieceInfo(index: ball.indexes)
            let startSide = "left"
            if let endSide = piece.side.left.exitSide {
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                }
            } else {
                print("crashed into a wall, or no track in place")
            }
            return
            
        case "right":
            
            let piece = getPieceInfo(index: ball.indexes)
            let startSide = "right"
            if let endSide = piece.side.right.exitSide {
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                }
            } else {
                print("crashed into a wall, or no track in place")
            }
            return

        default:
            break
        }
    }
    
    func handleTap(center: CGPoint) {
                
        for piece in board.pieces {
            
            if board.grid[piece.indexes] == center {
                
                piece.switch4Tap()
                
                delegate?.pieceWasTapped(piece: piece)
            }
        }
        
        for ball in board.balls {
            
            print("begin was tapped. Moving ball now \(board.balls.count)")
            
            if board.grid[ball.indexes] == center {
                
                for piece in board.pieces {
                    
                    piece.view.isUserInteractionEnabled = false
                }
                
                board.view.isUserInteractionEnabled = false
                
                moveBall(ball: ball, startSide: "unmoved")
            }
        }
    }
}
