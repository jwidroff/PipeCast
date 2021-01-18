//
//  Model.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 8/18/20.
//  Copyright © 2020 Jeffery Widroff. All rights reserved.
//

import Foundation
import UIKit



//TODO: Make the possibility for more balls in each entrance


//TODO: Give pieces the ability to rotate (May want to consider the cross piece

//TODO: Make a piece that rotates pieces

//TODO: Make the pieces have a PATH? var and use it only once instead of all the times it's being used

//TODO: Make cracks for ice

//TODO: Swipes left label

//TODO: Make a ball stopper piece

//TODO: Make a gradient for the colorChangers view

//TODO: Figure out why the currentSwitch being changed for the cross in the ShapeView still works

//TODO: Make the board have a more 3D look

//TODO: Make the buttons do what they're supposed to do

//TODO: Possibly change the cross to rotate instead of switching

//TODO: Make multiple exits to make levels easier

//TODO: Make popup for when player wins/loses

//TODO: Set up popup to come up when a ball falls off the board or when there are no more entrances or exits or pieces to move

//TODO: Make logic for when a player wins

//TODO: Consider making the entrances and exits moveable until its clicked

//TODO: Consider making walls that have the power to move and freeze in place

//TODO: Consider making the path that the ball goes through into locked pieces so that when you start that ball, you can still move pieces to get the other bal from the other entrance in easier to the other exit

//TODO:


protocol ModelDelegate {
    func setUpGame(board: Board)
    func setUpPiecesView()
    func movePieces(piece: Piece, direction: UISwipeGestureRecognizer.Direction)
    func pieceWasTapped(piece: Piece)
    func moveBallView(ball: Ball, piece: Piece, startSide: String, endSide: String)
    func addPieceView(piece: Piece)
    func resetPieceMaker(piece: Piece)
    func removePiece(piece: Piece)
    func ballCrashInCross(piece: Piece, ball: Ball)
    func removeBall(ball: Ball)
    func resetGame()
    func popup4WinOrLoss(title: String, message: String)
}

class Model {
    
    var board = Board()
    var level = Level()
    var delegate: ModelDelegate?
    
    init(){
        
    }
    
    func setUpGame() {
        
        getLevel()
        setBoard()
    }
    
    func getLevel() {
        
        let levelModel = LevelModel()
        self.board = levelModel.returnBoard(levelNumber: level.number)
    }
    
    func setBoard() {
        
        delegate?.setUpGame(board: self.board)
        
        delegate?.setUpPiecesView()
    }
    
    func setPieceSides(piece: Piece) {
      
        switch piece.shape {
            
        case .elbow:
            
            switch piece.version {

            case 1:
                
                //Top Pivot
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = nil
                    piece.side.right.color = nil
                    
                    piece.side.top.exitSide = "left"
                    piece.side.left.exitSide = "top"
                    piece.side.right.exitSide = nil
                    piece.side.bottom.exitSide = nil
                    
                } else if piece.currentSwitch == 2 {
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    
                    piece.side.top.color = piece.colors[0]
                    piece.side.right.color = piece.colors[0]
                    piece.side.bottom.color = nil
                    piece.side.left.color = nil
                    
                    piece.side.top.exitSide = "right"
                    piece.side.right.exitSide = "top"
                    piece.side.bottom.exitSide = nil
                    piece.side.left.exitSide = nil
                }
                
            case 2:
                
                //Left Pivot
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    
                    piece.side.bottom.exitSide = "left"
                    piece.side.left.exitSide = "bottom"
                    piece.side.right.exitSide = nil
                    piece.side.top.exitSide = nil
                    
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.top.color = nil
                    piece.side.right.color = nil
                    
                } else if piece.currentSwitch == 2 {
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    
                    piece.side.top.exitSide = "left"
                    piece.side.left.exitSide = "top"
                    piece.side.right.exitSide = nil
                    piece.side.bottom.exitSide = nil

                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = nil
                    piece.side.right.color = nil
                }
                
            case 3:
                
                //Bottom Pivot
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.bottom.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.exitSide = "bottom"
                    piece.side.top.exitSide = nil
                    piece.side.left.exitSide = nil

                    piece.side.bottom.color = piece.colors[0]
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = nil
                    piece.side.left.color = nil

                } else if piece.currentSwitch == 2 {
                    
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    
                    piece.side.bottom.exitSide = "left"
                    piece.side.left.exitSide = "bottom"
                    piece.side.right.exitSide = nil
                    piece.side.top.exitSide = nil
                    
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.top.color = nil
                    piece.side.right.color = nil
                }
                
            case 4:
                
                //Right Pivot
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    
                    piece.side.top.exitSide = "right"
                    piece.side.right.exitSide = "top"
                    piece.side.bottom.exitSide = nil
                    piece.side.left.exitSide = nil
                    
                    piece.side.top.color = piece.colors[0]
                    piece.side.right.color = piece.colors[0]
                    piece.side.bottom.color = nil
                    piece.side.left.color = nil

                } else if piece.currentSwitch == 2 {
                    
                    piece.side.bottom.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.exitSide = "bottom"
                    piece.side.top.exitSide = nil
                    piece.side.left.exitSide = nil
                    
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = nil
                    piece.side.left.color = nil
                }
                
            default:
                break
            }
            
        case .cross:
            
            print(piece.version)
            print(piece.currentSwitch)
            
            piece.side.right.exitSide = "left"
            piece.side.left.exitSide = "right"
            piece.side.top.exitSide = "bottom"
            piece.side.bottom.exitSide = "top"
            
            piece.side.right.color = piece.colors[1]
            piece.side.left.color = piece.colors[1]
            piece.side.top.color = piece.colors[0]
            piece.side.bottom.color = piece.colors[0]
            
            piece.side.top.opening.isOpen = true
            piece.side.bottom.opening.isOpen = true
            piece.side.left.opening.isOpen = true
            piece.side.right.opening.isOpen = true
            
            switch piece.version {
            
            case 1, 3:
                
                if piece.currentSwitch == 1 {
                    
                    //Horizontal Pipe on top

                    piece.side.left.closing.isOpen = true
                    piece.side.right.closing.isOpen = true
                    piece.side.top.closing.isOpen = false
                    piece.side.bottom.closing.isOpen = false
                    
                } else if piece.currentSwitch == 2 {
                    
                    //Vertical Pipe on top

                    piece.side.left.closing.isOpen = false
                    piece.side.right.closing.isOpen = false
                    piece.side.top.closing.isOpen = true
                    piece.side.bottom.closing.isOpen = true
                }

            case 2, 4:
                
                if piece.currentSwitch == 1 {
                    
                    //Horizontal Pipe on top

                    piece.side.left.closing.isOpen = true
                    piece.side.right.closing.isOpen = true
                    piece.side.top.closing.isOpen = false
                    piece.side.bottom.closing.isOpen = false
                    
                } else if piece.currentSwitch == 2 {
                    
                    //Vertical Pipe on top
                    
                    piece.side.left.closing.isOpen = false
                    piece.side.right.closing.isOpen = false
                    piece.side.top.closing.isOpen = true
                    piece.side.bottom.closing.isOpen = true
                }
                
            default:
                break
                
            }
//
//            print("piece.colors \(piece.colors)")
//            print("piece.version \(piece.version)")
//            print("piece.currentSwitch \(piece.currentSwitch)")
//            print("piece.side.top.closing.isOpen \(piece.side.top.closing.isOpen)")
//            print("piece.side.bottom.closing.isOpen \(piece.side.bottom.closing.isOpen)")
//            print("piece.side.left.closing.isOpen \(piece.side.left.closing.isOpen)")
//            print("piece.side.right.closing.isOpen \(piece.side.right.closing.isOpen)")
//            print("piece.side.top.color \(piece.side.top.color)")
//            print("piece.side.bottom.color \(piece.side.bottom.color)")
//            print("piece.side.left.color \(piece.side.left.color)")
//            print("piece.side.right.color \(piece.side.right.color)")

        case .stick:
            
            switch piece.version {
            case 1, 3:
                
//                if piece.currentSwitch == 1 {
                    
                    piece.side.right.exitSide = "left"
                    piece.side.left.exitSide = "right"
                    piece.side.right.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    
//                } else if piece.currentSwitch == 2 {
//
//                    piece.side.top.exitSide = "bottom"
//                    piece.side.bottom.exitSide = "top"
//                    piece.side.top.color = piece.colors[0]
//                    piece.side.bottom.color = piece.colors[0]
//                    piece.side.top.opening.isOpen = true
//                    piece.side.bottom.opening.isOpen = true
//                }
                
            case 2, 4:
                
//                if piece.currentSwitch == 1 {
                    
                    piece.side.top.exitSide = "bottom"
                    piece.side.bottom.exitSide = "top"
                    piece.side.top.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    
//                } else if piece.currentSwitch == 2 {
//                    
//                    piece.side.right.exitSide = "left"
//                    piece.side.left.exitSide = "right"
//                    piece.side.right.color = piece.colors[1]
//                    piece.side.left.color = piece.colors[1]
//                    piece.side.left.opening.isOpen = true
//                    piece.side.right.opening.isOpen = true
//                }
                
            default:
                break
            }
            
        case .diagElbow:
            
            piece.side.top.opening.isOpen = true
            piece.side.bottom.opening.isOpen = true
            piece.side.left.opening.isOpen = true
            piece.side.right.opening.isOpen = true
            
            switch piece.version {
            
            case 1, 3:
                
                //Pivots on left and right

                if piece.currentSwitch == 1 {

                    piece.side.right.exitSide = "top"
                    piece.side.left.exitSide = "bottom"
                    piece.side.top.exitSide = "right"
                    piece.side.bottom.exitSide = "left"
                    
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[1]
                    piece.side.bottom.color = piece.colors[1]
                    
                } else if piece.currentSwitch == 2 {

                    piece.side.right.exitSide = "bottom"
                    piece.side.left.exitSide = "top"
                    piece.side.top.exitSide = "left"
                    piece.side.bottom.exitSide = "right"
                    
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[1]
                    piece.side.bottom.color = piece.colors[0]
                }
                
            case 2, 4:
                
                //Pivots on top and bottom
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.left.exitSide = "top"
                    piece.side.right.exitSide = "bottom"
                    piece.side.bottom.exitSide = "right"
                    piece.side.top.exitSide = "left"
                    
                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[1]
                
                } else if piece.currentSwitch == 2 {

                    piece.side.left.exitSide = "bottom"
                    piece.side.right.exitSide = "top"
                    piece.side.bottom.exitSide = "left"
                    piece.side.top.exitSide = "right"
                    
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[1]
                    piece.side.bottom.color = piece.colors[1]
                }
                    
            default:
                break
            }
            
        default:
            break
        }
    }
    
    func setPieceSwitches(piece: Piece) {
        
        switch piece.shape {
        
        case .elbow:
            
            piece.switches = 2
            piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
            
        case .diagElbow:
            
            let pivotDecision = Int(arc4random_uniform(UInt32(2))) + 1
            
            switch pivotDecision {
            case 1:
                piece.switches = 2
                piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
                
            case 2:
                piece.switches = 1
                piece.currentSwitch = 1
                piece.doesPivot = false
                
            default:
                break
            }
            
        case .cross:
            
            piece.switches = 2
            piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
            
        case .stick:
            
            piece.switches = 1
            piece.currentSwitch = Int(arc4random_uniform(UInt32(1))) + 1
            
        default:
            break
        }
    }
    
    func setPieceShape(piece: Piece) {
        
        let version = Int(arc4random_uniform(UInt32(4))) + 1
        piece.version = version
        let randomShapes:[Shape] = board.randomPieceShapes//, .elbow, .stick]// .doubleElbow, .quadBox, .diagElbow]//, "sword"]
        piece.shape = randomShapes[Int(arc4random_uniform(UInt32(randomShapes.count)))]
    }
    
    func setPieceColor(piece: Piece) {
        
        let randomColors:[UIColor] = board.randomPieceColors//, UIColor.blue]//, UIColor.green, UIColor.purple, UIColor.yellow, UIColor.orange]//, UIColor.white, UIColor.cyan]
        let randomColor1 = randomColors[Int(arc4random_uniform(UInt32(randomColors.count)))]
        let randomColor2 = randomColors[Int(arc4random_uniform(UInt32(randomColors.count)))]
        
        piece.colors = [randomColor1, randomColor2]
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
            }
        }
        return piece
    }
    
    func checkForIce(piece: Piece) -> Bool {

        var bool = false

        if board.iceLocations.contains(where: { (index) -> Bool in
            index == piece.indexes
        }) {
            bool = true
        }
        return bool
    }
    
    func checkForHole(piece: Piece) -> Bool {

        var bool = false

        if board.holeLocations.contains(where: { (index) -> Bool in
            index == piece.indexes
        }) {
            bool = true
        }
        return bool
    }
    
    
    func resetPieceMaker(piece: Piece) {
                
        let nextPiece = Piece()
        nextPiece.indexes = piece.indexes
        setPieceShape(piece: nextPiece)
        setPieceColor(piece: nextPiece)
        setPieceSwitches(piece: nextPiece)
        setPieceSides(piece: nextPiece)
        piece.nextPiece = nextPiece
        delegate?.resetPieceMaker(piece: piece)
    }
    
    func throwPieceOffEdge(piece: Piece) {
        
        if piece.isLocked == false {
            
            print("throw piece off the board!")
            //put delegate here
            
            
            
            //Remove Piece
//            board.pieces.removeAll { (pieceX) -> Bool in
//                pieceX.indexes.x! < 0 || pieceX.indexes.x! > level.board.widthSpaces - 1 || pieceX.indexes.y < 0 || pieceX.indexes.y! > level.board.heightSpaces - 1
//            }
            

        }
        
        
    }
    
    func movePiecesHelper(piece: Piece, direction: UISwipeGestureRecognizer.Direction) {
        
        switch direction {
        
        case .up:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .up, indexes: piece.indexes)
            
//            let notAtWall = piece.indexes.y != 0
            
//            if notAtWall {
                
                if spaceIsntBlocked {
                                        
                    if piece.shape != .pieceMaker {
                        
                        if piece.isLocked == false {
                            
                            piece.indexes.y = piece.indexes.y! - 1
                            
                            if piece.shape == .entrance {
                                
                                for ball in board.balls {
                                    
                                    if ball.indexes == Indexes(x: piece.indexes.x, y: piece.indexes.y! + 1) {
                                        
                                        ball.indexes = piece.indexes
                                        
                                    }
                                    
                                }
                            }
                            
                            if checkForIce(piece: piece) == true {
                                delegate?.movePieces(piece: piece, direction: direction)
                                movePiecesHelper(piece: piece, direction: direction)
                                return
                            }
                            
                            if checkForHole(piece: piece) == true {
                                
                                
                                deletePiece(piece: piece)
                               
                            }
                            
                            
                            
//                            if checkForHole(piece: piece) == true {
//
//
//                                deletePiece(piece: piece)
//
//                            }
                            
                            
                        }
                        
                    } else {
                        
                        if piece.version == 3 {
                                                        
                            if piece.nextPiece != nil {
                                
                                let newPiece = piece.nextPiece!
                                
                                newPiece.view = ShapeView(frame: piece.view.frame, piece: newPiece)
                                                                
                                delegate?.addPieceView(piece: newPiece)
                                
                                board.pieces.append(newPiece)
                                
                                newPiece.indexes.y = newPiece.indexes.y! - 1
                                
                                delegate?.movePieces(piece: newPiece, direction: direction)
                                
                                if checkForIce(piece: newPiece) == true {
                                    movePiecesHelper(piece: newPiece, direction: direction)
                                    return
                                }
                                
                                if checkForHole(piece: newPiece) == true {
                                    
                                    
                                    deletePiece(piece: newPiece)
                                   
                                }
                                
                                resetPieceMaker(piece: piece)
                            }
                        }
                    }
                }
//            } else {
//
//
//
//
//                throwPieceOffEdge(piece: piece)
//
//
//            }
           
        case .down:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .down, indexes: piece.indexes)
            
//            let notAtWall = piece.indexes.y != board.grid.keys.map({$0.y!}).max(by: { (int1, int2) -> Bool in
//                return int1 < int2
//            })
//
//            if notAtWall {
                
                if spaceIsntBlocked {
                    
                    if piece.shape != .pieceMaker {
                                                
                        if piece.isLocked == false {
                            
                            piece.indexes.y = piece.indexes.y! + 1
                            
                            if piece.shape == .entrance {
                                
                                for ball in board.balls {
                                    
                                    if ball.indexes == Indexes(x: piece.indexes.x, y: piece.indexes.y! - 1) {
                                        
                                        ball.indexes = piece.indexes
                                        
                                    }
                                    
                                }
                            }
                            
                            if checkForIce(piece: piece) == true {
                                
                                delegate?.movePieces(piece: piece, direction: direction)
                                movePiecesHelper(piece: piece, direction: direction)
                                return

                            }
                            
                            if checkForHole(piece: piece) == true {
                                
                                
                                deletePiece(piece: piece)
                               
                            }
                            
                            
                            
//                            if checkForHole(piece: piece) == true {
//
//
//                                deletePiece(piece: piece)
//
//                            }
                            
                        }
                        
                    } else {
                                                
                        if piece.version == 1 {
                            
                            if piece.nextPiece != nil {

                                let newPiece = piece.nextPiece!
                                
                                newPiece.view = ShapeView(frame: piece.view.frame, piece: newPiece)

                                delegate?.addPieceView(piece: newPiece)
                                
                                board.pieces.append(newPiece)
                                
                                newPiece.indexes.y = newPiece.indexes.y! + 1
                                
                                delegate?.movePieces(piece: newPiece, direction: direction)
                                
                                if checkForIce(piece: newPiece) == true {
                                    
                                    
                                    movePiecesHelper(piece: newPiece, direction: direction)
                                    return

                                }
                                
                                if checkForHole(piece: newPiece) == true {
                                    
                                    
                                    deletePiece(piece: newPiece)
                                   
                                }
                                
                                resetPieceMaker(piece: piece)
                            }
                        }
                    }
                }
//            } else {
//
//                throwPieceOffEdge(piece: piece)
//
//
//            }
            
            
        case .left:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .left, indexes: piece.indexes)
            
//            let notAtWall = piece.indexes.x != 0
//
//            if notAtWall {
                
                if spaceIsntBlocked {
                    
                    if piece.shape != .pieceMaker {
                        
                        if piece.isLocked == false {
                            
                            piece.indexes.x = piece.indexes.x! - 1
                            
                            if piece.shape == .entrance {
                                
                                for ball in board.balls {
                                    
                                    if ball.indexes == Indexes(x: piece.indexes.x! + 1, y: piece.indexes.y) {
                                        
                                        ball.indexes = piece.indexes
                                        
                                    }
                                    
                                }
                            }
                            
                            if checkForIce(piece: piece) == true {
                                delegate?.movePieces(piece: piece, direction: direction)
                                movePiecesHelper(piece: piece, direction: direction)
                            }
                            
                            if checkForHole(piece: piece) == true {
                                
                                
                                deletePiece(piece: piece)
                               
                            }
                            
                            
                            
//                            if checkForHole(piece: piece) == true {
//
//
//                                deletePiece(piece: piece)
//
//                            }
                        }
                        
                    } else {
                        
                        if piece.version == 2 {
                            
                            if piece.nextPiece != nil {
                                
                                let newPiece = piece.nextPiece!
                                
                                newPiece.view = ShapeView(frame: piece.view.frame, piece: newPiece)

                                delegate?.addPieceView(piece: newPiece)

                                board.pieces.append(newPiece)
                                
                                newPiece.indexes.x = newPiece.indexes.x! - 1
                                
                                delegate?.movePieces(piece: newPiece, direction: direction)

                                if checkForIce(piece: newPiece) == true {
                                    movePiecesHelper(piece: newPiece, direction: direction)
                                }
                                
                                if checkForHole(piece: newPiece) == true {
                                    
                                    
                                    deletePiece(piece: newPiece)
                                   
                                }
                                
                                resetPieceMaker(piece: piece)
                            }
                        }
                    }
                }
//            } else {
//
//                throwPieceOffEdge(piece: piece)
//
//
//            }
            
        case .right:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .right, indexes: piece.indexes)
            
//            let notAtWall = piece.indexes.x != board.grid.keys.map({$0.x!}).max(by: { (int1, int2) -> Bool in
//                return int1 < int2
//            })
//
//            if notAtWall {
                
                if spaceIsntBlocked {
                    
                    if piece.shape != .pieceMaker {
                        
                        if piece.isLocked == false {
                           
                            piece.indexes.x = piece.indexes.x! + 1
                            
                            if piece.shape == .entrance {
                                
                                for ball in board.balls {
                                    
                                    if ball.indexes == Indexes(x: piece.indexes.x! - 1, y: piece.indexes.y) {
                                        
                                        ball.indexes = piece.indexes
                                        
                                    }
                                    
                                }
                            }
                            
                            if checkForIce(piece: piece) == true {
                                delegate?.movePieces(piece: piece, direction: direction)
                                movePiecesHelper(piece: piece, direction: direction)
                            }
                            
                            
                            if checkForHole(piece: piece) == true {
                                
                                
                                deletePiece(piece: piece)
                               
                            }
                            
                        }
                        
                    } else {
                        
                        if piece.nextPiece != nil {
                            
                            if piece.version == 4 {
                                
                                let newPiece = piece.nextPiece!
                                
                                newPiece.view = ShapeView(frame: piece.view.frame, piece: newPiece)

                                delegate?.addPieceView(piece: newPiece)
                                
                                board.pieces.append(newPiece)
                                
                                newPiece.indexes.x = newPiece.indexes.x! + 1
                                
                                delegate?.movePieces(piece: newPiece, direction: direction)

                                if checkForIce(piece: newPiece) == true {
                                    movePiecesHelper(piece: newPiece, direction: direction)
                                }
                                
                                if checkForHole(piece: newPiece) == true {
                                    
                                    
                                    deletePiece(piece: newPiece)
                                   
                                }
                                
                                resetPieceMaker(piece: piece)
                            }
                        }
                    }
                }
        default:
            break
        }
                
    }
    
    func deletePiece(piece: Piece) {
        
        //Animation works but need to put in the right place becuase right not the piece doesnt move before its removed. Need to call after the piece moves
        
        board.pieces.removeAll { (piece) -> Bool in
            
            if piece.indexes.x! < 0 || piece.indexes.x! > board.widthSpaces - 1 || piece.indexes.y! < 0 || piece.indexes.y! > board.heightSpaces - 1 {
                
                delegate?.removePiece(piece: piece)

                return true
            }
            
            return false
        }
        
        board.pieces.removeAll { (piece) -> Bool in

            for holeLocation in board.holeLocations {

                if holeLocation == piece.indexes {

                    delegate?.removePiece(piece: piece)
                    
                    print("deleted piece - Need to animate this in the VC")
                    return true
                }
            }
            return false
        }
    }
    
    func deleteBall(ball: Ball) {
        
        
        board.balls.removeAll { (ball) -> Bool in
            
            if ball.indexes.x! < 0 || ball.indexes.x! > board.widthSpaces - 1 || ball.indexes.y! < 0 || ball.indexes.y! > board.heightSpaces - 1 {
                
                delegate?.removeBall(ball: ball)

                return true
            }
            
            return false
        }
        
        board.balls.removeAll { (ball) -> Bool in

            for holeLocation in board.holeLocations {

                if holeLocation == ball.indexes {

                    delegate?.removeBall(ball: ball)
                    
                    print("deleted piece - Need to animate this in the VC")
                    return true
                }
            }
            return false
        }
    }
    
    
    func movePiece(direction: UISwipeGestureRecognizer.Direction) {
        
        switch direction {
            
        case .up:
                        
            for piece in board.pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.y! < piece2.indexes.y!
            })
//            .filter({ (piece) -> Bool in
//                piece.isLocked == false
//            })
            {
                movePiecesHelper(piece: piece, direction: direction)
                delegate?.movePieces(piece: piece, direction: direction)

            }
            
            
        //            delegate?.movePieces(direction: direction)


        case .down:
            for piece in board.pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.y! > piece2.indexes.y!
                
            })
//            .filter({ (piece) -> Bool in
//                piece.isLocked == false
//            })
            {
                movePiecesHelper(piece: piece, direction: direction)
                delegate?.movePieces(piece: piece, direction: direction)

            }
            
        //            delegate?.movePieces(direction: direction)


        case .left:
            for piece in board.pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.x! < piece2.indexes.x!
            })
//            .filter({ (piece) -> Bool in
//                piece.isLocked == false
//            })
            {
                movePiecesHelper(piece: piece, direction: direction)
                delegate?.movePieces(piece: piece, direction: direction)

            }
            
//            delegate?.movePieces(direction: direction)

        case .right:
            for piece in board.pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.x! > piece2.indexes.x!
            })
//            .filter({ (piece) -> Bool in
//                piece.isLocked == false
//            })
            {
                movePiecesHelper(piece: piece, direction: direction)
                delegate?.movePieces(piece: piece, direction: direction)

            }
//            delegate?.movePieces(direction: direction)

        default:
            break
        }
        
        check4GameOver()
    }
    
    func check4GameOver() {
        
        //Check if Board has any more balls (if not, game over)

        if board.balls.count == 0 {
            
            print("no more balls in the game - Create delegate func here to end the game and NOT move up a level")
            return
        }
    }
    
    
    
//    func winner() {
//
//        print("you win")
//
//    }
    
    var waitAmount = 0.25
        
    func moveBall(ball: Ball, startSide: String) {
        
        let piece = getPieceInfo(index: ball.indexes)
        
        switch startSide {
        
        case "unmoved":
            
            let startSide = "center"
            let endSide = piece.opening
            
            switch piece.opening {
            
            case "top":
                ball.onColor = piece.side.top.color!
            case "bottom":
                ball.onColor = piece.side.bottom.color!
            case "left":
                ball.onColor = piece.side.left.color!
            case "right":
                ball.onColor = piece.side.right.color!
            default:
                break
            }
            
            delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
            
            
            
        case "top":
            
            let startSide = "top"

            if piece.side.top.color != ball.onColor { return }
            
            
            
            if let endSide = piece.side.top.exitSide {
                
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    
                    if piece.shape == .colorChanger {
                        
                        ball.onColor = piece.side.bottom.color!
                    }
                    
                    
                    if piece.shape == .cross {
                        
                        if piece.side.top.closing.isOpen == false {
                            
                            delegate?.ballCrashInCross(piece: piece, ball: ball)

//                            delegate?.popup4WinOrLoss(title: "YOU LOSE", message: "TRY AGAIN?")
                            return
                            
                        }
                    }
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                    
                    
                }
            } else {
                print("crashed into a wall, or no track in place")
            }
            
            
        case "bottom":
            
            let startSide = "bottom"
            
            if piece.side.bottom.color != ball.onColor { return }
            
            if let endSide = piece.side.bottom.exitSide {
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    
                    if piece.shape == .colorChanger {
                        
                        ball.onColor = piece.side.top.color!
                    }
                    
                    
                    if piece.shape == .cross {
                        
                        if piece.side.bottom.closing.isOpen == false {
                            
                            delegate?.ballCrashInCross(piece: piece, ball: ball)
                            print("need to move ball halfway")
                            return
                            
                        }
                        
                    }
                        
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                    
                    
                }
            } else {
                
                print("crashed into a wall, or no track in place")
            }
            
            
        case "left":
            
            let startSide = "left"

            if piece.side.left.color != ball.onColor { return }
            
            if let endSide = piece.side.left.exitSide {
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    
                    if piece.shape == .colorChanger {
                        
                        ball.onColor = piece.side.right.color!
                    }
                    
                    if piece.shape == .cross {
                        
                        if piece.side.left.closing.isOpen == false {
                            
                            delegate?.ballCrashInCross(piece: piece, ball: ball)
                            print("need to move ball halfway")
                            return
                        }
                    }
                        
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                    
                    
                }
            } else {
                print("crashed into a wall, or no track in place")
            }
            
            
        case "right":
            
            let startSide = "right"

            if piece.side.right.color != ball.onColor { return }
            
            if let endSide = piece.side.right.exitSide {
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    
                    if piece.shape == .colorChanger {
                        
                        ball.onColor = piece.side.left.color!
                    }
                    
                    if piece.shape == .cross {
                        
                        if piece.side.right.closing.isOpen == false {
                            
                            delegate?.ballCrashInCross(piece: piece, ball: ball)
                            print("need to move ball halfway")
                            return
                        }
                    }
                        
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                    
                }
            } else {
                print("crashed into a wall, or no track in place")
            }
            
        default:
            break
        }
        
        check4Winner(piece: piece)
        
        
    }
    
    func check4Winner(piece: Piece) {
        
        if piece.shape == .exit {
            
            print("YOU WIN!!!!!!!!!!!!!!!!!!!!!!!")
            
            
            level.number += 1
            
            delegate?.popup4WinOrLoss(title: "YOU WIN", message: "Great Job - Next Level?")
        }
    }
    
    
    
    func handleTap(center: CGPoint) {
                
        for piece in board.pieces {
            
            if board.grid[piece.indexes] == center && piece.shape != .entrance {
                
//                print(piece.version)
//                print(piece.currentSwitch)

                
                switch4Tap(piece: piece) { (false) in
                    piece.view.setNeedsDisplay()
                }
            }
        }
        
        for ball in board.balls {
                        
            if board.grid[ball.indexes] == center {
                
                for piece in board.pieces {
                    
                    //TODO: Change this back
                    piece.view.isUserInteractionEnabled = false
                }
                
                board.view.isUserInteractionEnabled = false
                
                moveBall(ball: ball, startSide: "unmoved")
            }
        }
    }
    
    func switch4Tap(piece: Piece,  completion: @escaping (Bool) -> Void) {
        
        if piece.isLocked || piece.doesPivot == false { return }
        
        if piece.currentSwitch != piece.switches {
            
            piece.currentSwitch += 1
            print("current switch changed")
        } else {
            
            piece.currentSwitch = 1
            print("current switch changed")

        }

        switch piece.shape {
        
        case .cross:
            
            piece.side.left.closing.isOpen = !piece.side.left.closing.isOpen
            piece.side.right.closing.isOpen = !piece.side.right.closing.isOpen
            piece.side.top.closing.isOpen = !piece.side.top.closing.isOpen
            piece.side.bottom.closing.isOpen = !piece.side.bottom.closing.isOpen

        case .elbow:
            
            switch piece.version {
            
            case 1:
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.top.exitSide = "left"
                    piece.side.left.exitSide = "top"
                    piece.side.right.exitSide = nil
                    piece.side.bottom.exitSide = nil
                    
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.right.color = nil
                    piece.side.bottom.color = nil
                    
                } else if piece.currentSwitch == 2 {

                    piece.side.top.exitSide = "right"
                    piece.side.right.exitSide = "top"
                    piece.side.left.exitSide = nil
                    piece.side.bottom.exitSide = nil
                    
                    piece.side.top.color = piece.colors[0]
                    piece.side.right.color = piece.colors[0]
                    piece.side.left.color = nil
                    piece.side.bottom.color = nil
                }
                
                piece.side.left.opening.isOpen = !piece.side.left.opening.isOpen
                piece.side.right.opening.isOpen = !piece.side.right.opening.isOpen

            case 2:
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.left.exitSide = "bottom"
                    piece.side.bottom.exitSide = "left"
                    piece.side.top.exitSide = nil
                    piece.side.right.exitSide = nil
                    
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.right.color = nil
                    piece.side.top.color = nil
                    
                } else if piece.currentSwitch == 2 {

                    piece.side.left.exitSide = "top"
                    piece.side.top.exitSide = "left"
                    piece.side.bottom.exitSide = nil
                    piece.side.right.exitSide = nil
                    
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.right.color = nil
                    piece.side.bottom.color = nil
                }
                
                piece.side.top.opening.isOpen = !piece.side.top.opening.isOpen
                piece.side.bottom.opening.isOpen = !piece.side.bottom.opening.isOpen
                
            case 3:
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.exitSide = "bottom"
                    piece.side.left.exitSide = nil
                    piece.side.top.exitSide = nil
                    
                    piece.side.right.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.left.color = nil
                    piece.side.top.color = nil
                    
                } else if piece.currentSwitch == 2 {

                    piece.side.bottom.exitSide = "left"
                    piece.side.left.exitSide = "bottom"
                    piece.side.right.exitSide = nil
                    piece.side.top.exitSide = nil

                    piece.side.bottom.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.right.color = nil
                    piece.side.top.color = nil
                }
                
                piece.side.left.opening.isOpen = !piece.side.left.opening.isOpen
                piece.side.right.opening.isOpen = !piece.side.right.opening.isOpen
                
            case 4:
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.right.exitSide = "top"
                    piece.side.top.exitSide = "right"
                    piece.side.bottom.exitSide = nil
                    piece.side.left.exitSide = nil

                    piece.side.top.color = piece.colors[0]
                    piece.side.right.color = piece.colors[0]
                    piece.side.left.color = nil
                    piece.side.bottom.color = nil
                    
                } else if piece.currentSwitch == 2 {

                    piece.side.right.exitSide = "bottom"
                    piece.side.bottom.exitSide = "right"
                    piece.side.top.exitSide = nil
                    piece.side.left.exitSide = nil

                    piece.side.bottom.color = piece.colors[0]
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = nil
                    piece.side.left.color = nil
                }
                
                piece.side.top.opening.isOpen = !piece.side.top.opening.isOpen
                piece.side.bottom.opening.isOpen = !piece.side.bottom.opening.isOpen
                
            default:
                break
            }
            
        case .diagElbow:
            
            switch piece.version {
            
            case 1, 3:
                
                //Pivots on right and left
                
                if piece.currentSwitch == 1 {
                
                    piece.side.right.exitSide = "top"
                    piece.side.left.exitSide = "bottom"
                    piece.side.top.exitSide = "right"
                    piece.side.bottom.exitSide = "left"
                    
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[1]
                    piece.side.bottom.color = piece.colors[1]
                    
                } else if piece.currentSwitch == 2 {
                    
                    piece.side.top.exitSide = "left"
                    piece.side.left.exitSide = "top"
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.exitSide = "bottom"
                    
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[1]
                    piece.side.bottom.color = piece.colors[0]
                }
                
            case 2, 4:
                
                //Pivots on top and bottom

                if piece.currentSwitch == 1 {
                
                    piece.side.top.exitSide = "left"
                    piece.side.left.exitSide = "top"
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.exitSide = "bottom"
                    
                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[1]
                    
                } else if piece.currentSwitch == 2 {
                    
                    piece.side.right.exitSide = "top"
                    piece.side.left.exitSide = "bottom"
                    piece.side.top.exitSide = "right"
                    piece.side.bottom.exitSide = "left"
                    
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[1]
                    piece.side.bottom.color = piece.colors[1]
                }
            
            default:
                break
            }
            
        default:
            break
        }
        
        completion(true)
    }
    
    
    func resetGame() {
        
        for piece in board.pieces {
            
            print("piece should be deleting")
            delegate?.removePiece(piece: piece)
            
        }
        board.pieces.removeAll()
        
        for ball in board.balls {
            
            print("piece should be deleting")
            delegate?.removeBall(ball: ball)
            
        }
        board.balls.removeAll()
        
//        setUpGame()
        
//        completion(true)
    }
    
    
    
}
