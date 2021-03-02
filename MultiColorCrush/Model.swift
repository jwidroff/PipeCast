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


//TODO: Consider making walls that have the power to move and freeze in place


//TODO: Make it that the pieceMaker can also spit out walls


//TODO: Make the buttons show that theyre being pressed



//TODO: CREATE DOUBLE ELBOW PIECE


//TODO: Need to make the entrance tile look locked after the button is pressed

//TODO: May need to utilize the closing property for the doubleElbow when is comes in from a side but the pivot is the other way


//TODO: See if you can get rid of all the "opening" properties for all piece shapes except for the cross


//TODO: Latest issue is that switching of the piece after the ball moves 

//TODO: Fix the ball popping in and out on when its moving

//TODO: Make a variable on the ball piece called pieces that ball passed through and use it instead of the model var

//TODO: Test doubleElbow and make sure that it was made correctly

//TODO: Fix initial animation. Seems to be choppy right at the start

protocol ModelDelegate {
    func setUpGame(board: Board)
    func setUpPiecesView()
    func movePieces(piece: Piece, direction: UISwipeGestureRecognizer.Direction)
//    func pieceWasTapped(piece: Piece)
    func moveBallView(ball: Ball, piece: Piece, startSide: String, endSide: String)
    func addPieceView(piece: Piece)
    func resetPieceMaker(piece: Piece)
    func removePiece(piece: Piece)
    func ballCrashInCross(piece: Piece, ball: Ball)
    func removeBall(ball: Ball)
    func runPopUpView(title: String, message: String)
    func clearPiecesAnimation(view: UIView)
//    func animateMove(ball: Ball)
    func removePieceAfterBall(piece: Piece)
    func replacePiece(piece: Piece)
}

class Model {
    
    var board = Board()
    var level = Level()
    var delegate: ModelDelegate?
//    var piecesThatBallPassedThrough = [Piece]() //MARK: Make this a property of the ball
    var gameOver = false
    
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
            
        case .stick:
            
            switch piece.version {
            case 1, 3:
                
                piece.side.right.exitSide = "left"
                piece.side.left.exitSide = "right"
                piece.side.right.color = piece.colors[0]
                piece.side.left.color = piece.colors[0]
                piece.side.left.opening.isOpen = true
                piece.side.right.opening.isOpen = true
                
            case 2, 4:
                
                piece.side.top.exitSide = "bottom"
                piece.side.bottom.exitSide = "top"
                piece.side.top.color = piece.colors[0]
                piece.side.bottom.color = piece.colors[0]
                piece.side.top.opening.isOpen = true
                piece.side.bottom.opening.isOpen = true

            default:
                break
            }
            
        case .doubleElbow:
            
            //MARK: Finish this off
            
            switch piece.version {
            case 1:
                
                print()
                
                if piece.currentSwitch == 1 {
                                        
                    
                    
                    
                    //TODO: JUST SET THIS UP. NEED TO FINISH FOR ALL VERSIONS AND CURRENTSWITCHS
                    
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = false
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "top"
                    piece.side.left.exitSide = "top"
                    piece.side.top.exitSide = "left"
                    piece.side.bottom.exitSide = nil
                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
//                    piece.side.bottom.color = piece.colors[1]
                    
                } else if piece.currentSwitch == 2 {
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = false
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "top"
                    piece.side.left.exitSide = "top"
                    piece.side.top.exitSide = "right"
                    piece.side.bottom.exitSide = nil
                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[0]
//                    piece.side.bottom.color = piece.colors[1]
                    
                    
                }
                
                
                
            case 2:
                print()

                if piece.currentSwitch == 1 {
                    
                    //left bottom
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = false
                    piece.side.right.exitSide = nil
                    piece.side.left.exitSide = "bottom"
                    piece.side.top.exitSide = "left"
                    piece.side.bottom.exitSide = "left"
//                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[0]
                    
                    
                } else if piece.currentSwitch == 2 {
                    
                    
                    //left top
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = false
                    piece.side.right.exitSide = nil
                    piece.side.left.exitSide = "top"
                    piece.side.top.exitSide = "left"
                    piece.side.bottom.exitSide = "left"
//                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[1]
                    piece.side.bottom.color = piece.colors[0]
                    
                    
                    
                }
                
                
            case 3:
                print()

                if piece.currentSwitch == 1 {
                    
                    //Pick up here
                    
                    //Bottom Left on top
                    
                    piece.side.top.opening.isOpen = false
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "bottom"
                    piece.side.left.exitSide = "bottom"
                    piece.side.top.exitSide = nil
                    piece.side.bottom.exitSide = "left"
                    piece.side.right.color = piece.colors[1]
//                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[0]
                    
                } else if piece.currentSwitch == 2 {
                    
                    //Bottom right on top

                    
                    piece.side.top.opening.isOpen = false
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "bottom"
                    piece.side.left.exitSide = "bottom"
                    piece.side.top.exitSide = nil
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.color = piece.colors[1]
//                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[1]
                    
                }
                
                
                
            case 4:
                
                print()

                if piece.currentSwitch == 1 {
                    
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = false
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "top"
                    piece.side.left.exitSide = nil
                    piece.side.top.exitSide = "right"
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = piece.colors[0]
//                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[1]
                    
                    
                } else if piece.currentSwitch == 2 {
                    
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = false
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "bottom"
                    piece.side.left.exitSide = nil
                    piece.side.top.exitSide = "right"
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[0]
//                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[1]
                    
                    
                    
                }
                
                
                
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
        
//        case .elbow:
//
//            piece.switches = 2
//            piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
            
        case .diagElbow, .elbow:
            
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
            
        case .doubleElbow:
            
            piece.switches = 2
            piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
            
        case .cross:
            
            piece.switches = 2
            piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
            
        case .stick:
            
            piece.switches = 1
            piece.currentSwitch = 1
            
        default:
            break
        }
    }
    
    func setPieceShape(piece: Piece) {
        
        let version = Int(arc4random_uniform(UInt32(4))) + 1
        piece.version = version
        let randomShapes:[Shape] = board.randomPieceShapes
        piece.shape = randomShapes[Int(arc4random_uniform(UInt32(randomShapes.count)))]
    }
    
    func setPieceColor(piece: Piece) {
        
        let randomColors:[UIColor] = board.randomPieceColors
        
//        if randomColors.count == 1 {
//
//            randomColors.append(randomColors[0])
//
//        }
        
        
        let randomColor1 = randomColors[Int(arc4random_uniform(UInt32(randomColors.count - 1)))]
        
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
    
    func movePiecesHelper(piece: Piece, direction: UISwipeGestureRecognizer.Direction) {
        
        switch direction {
        
        case .up:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .up, indexes: piece.indexes)
                
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
            
        case .down:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .down, indexes: piece.indexes)

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
            
        case .left:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .left, indexes: piece.indexes)

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
            
        case .right:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .right, indexes: piece.indexes)
                
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
                    return true
                }
            }
            return false
        }
    }
    
    func movePiece(direction: UISwipeGestureRecognizer.Direction) {
        
        switch direction {
            
        case .up:
            
            board.pieces.sort { (piece1, piece2) -> Bool in
                piece1.indexes.y! < piece2.indexes.y!
            }

        case .down:
            
            board.pieces.sort { (piece1, piece2) -> Bool in
                piece1.indexes.y! > piece2.indexes.y!
            }

        case .left:
            
            board.pieces.sort { (piece1, piece2) -> Bool in
                piece1.indexes.x! < piece2.indexes.x!
            }

        case .right:
            
            board.pieces.sort { (piece1, piece2) -> Bool in
                piece1.indexes.x! > piece2.indexes.x!
            }

        default:
            break
        }
        
        for piece in board.pieces {
            
            movePiecesHelper(piece: piece, direction: direction)
            delegate?.movePieces(piece: piece, direction: direction)
        }
        
        let gameIsOver = check4GameOver()
        if gameIsOver {

            delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
            return
        }
    }
    
    func check4GameOver() -> Bool {
        
        var bool = false
        if board.balls.count == 0 {
            
            bool = true
        }
        return bool
    }
    
            
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
            
            ball.piecesPassed.append(piece)

            delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
            
            
        case "top":
            
            let startSide = "top"
            

            if let endSide = piece.side.top.exitSide {
                
                if piece.side.top.color != ball.onColor {
                    
                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                    return
                }
                
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    
                    if piece.shape == .colorChanger {
                        
                        ball.onColor = piece.side.bottom.color!
                    }
                    
                    if piece.shape == .cross {
                        
                        if piece.side.top.closing.isOpen == false {
                            
                            delegate?.ballCrashInCross(piece: piece, ball: ball)
                            return
                        }
                    }
                    ball.piecesPassed.append(piece)
                    
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)

                }
            } else {
                
                delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                print("crashed into a wall, or no track in place")
                return
            }
            
            
        case "bottom":
            
            let startSide = "bottom"
            
            if let endSide = piece.side.bottom.exitSide {
                
                if piece.side.bottom.color != ball.onColor {
                    
                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                    return
                }
                
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    
                    if piece.shape == .colorChanger {
                        
                        ball.onColor = piece.side.top.color!
                    }
                    
                    if piece.shape == .cross {
                        
                        if piece.side.bottom.closing.isOpen == false {
                            
                            delegate?.ballCrashInCross(piece: piece, ball: ball)
                            return
                        }
                    }
                    ball.piecesPassed.append(piece)
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                    
                }
                
            } else {
                
                delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                
                print("crashed into a wall, or no track in place")
                return
            }
            
            
        case "left":
            
            let startSide = "left"

            if let endSide = piece.side.left.exitSide {
                
                if piece.side.left.color != ball.onColor {
                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                    return
                }
                
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    
                    if piece.shape == .colorChanger {
                        
                        ball.onColor = piece.side.right.color!
                    }
                    
                    if piece.shape == .cross {
                        
                        if piece.side.left.closing.isOpen == false {
                            
                            delegate?.ballCrashInCross(piece: piece, ball: ball)
                            return
                        }
                    }
                    ball.piecesPassed.append(piece)
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)

                }
                
            } else {
                delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                print("crashed into a wall, or no track in place")
                return
            }
            
        case "right":
            
            let startSide = "right"
            
            if let endSide = piece.side.right.exitSide {
                
                if piece.side.right.color != ball.onColor {
                    
                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                    return
                }
                
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    
                    if piece.shape == .colorChanger {
                        
                        ball.onColor = piece.side.left.color!
                    }
                    
                    if piece.shape == .cross {
                        
                        if piece.side.right.closing.isOpen == false {
                            
                            delegate?.ballCrashInCross(piece: piece, ball: ball)
                            return
                        }
                    }
                    ball.piecesPassed.append(piece)
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                
                }
                
            } else {
                delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                print("crashed into a wall, or no track in place")
                return
            }
        default:
            break
        }
        
       
//        checkIfBallExited(piece: piece, ball: ball)
    }
    
    
//    func checkIfBallExited(piece: Piece, ball: Ball) {
//
//        if piece.indexes == ball.indexes {
//
//            if piece.shape == .exit {
//
//                ball.exited = true
//
//                for piece in piecesThatBallPassedThrough {
//
//                    delegate?.removePiece(piece: piece)
//
//
//                }
//
//            }
//        }
//
//    }
    
    func checkIfBallExited(ball: Ball) {
        
        print("CIBE CALLED")
        
        
        for piece in board.pieces {

            if piece.indexes == ball.indexes {

                if piece.shape == .exit {

                    ball.exited = true

                    for piece in ball.piecesPassed {

                        delegate?.removePieceAfterBall(piece: piece)
                        
                        board.pieces.removeAll { (pieceX) -> Bool in
                            pieceX.indexes == piece.indexes
                        }
                        
                    }
                    
                    check4Winner(piece: getPieceInfo(index: ball.indexes))
                    
                }
            }
        }
    }
    
    
    func check4Winner(piece: Piece){
        
        if board.balls.contains(where: { (ball) -> Bool in
            ball.exited == false
            
        })
        { return }
        
        else {
            
            delegate?.runPopUpView(title: "YOU WIN", message: "Great Job - Next Level?")
            
            gameOver = true
            return
        }
    }
    
    func handleTap(center: CGPoint) {
                
        for piece in board.pieces {
            
            if board.grid[piece.indexes] == center && piece.shape != .entrance {
                
                switch4Tap(piece: piece) { (true) in
                    piece.view.setNeedsDisplay()
                }
            } else if board.grid[piece.indexes] == center && piece.shape == .entrance {
                
                for ball in board.balls {
                                
                    if board.grid[ball.indexes] == center {
                        
                        moveBall(ball: ball, startSide: "unmoved")
                        
                        
                        
                    }
                }
            }
        }
    }
    

    
    func switchCross(piece: Piece, ball: Ball) {
        
        
        print("switchCross")
        
        //PICK UP HERE - NEED TO FIX THE SWITCH FOR AFTER THE BALL GOES ACROSS THE CROSS PIECE
        
        
        piece.side.left.closing.isOpen = !piece.side.left.closing.isOpen
        piece.side.right.closing.isOpen = !piece.side.right.closing.isOpen
        piece.side.top.closing.isOpen = !piece.side.top.closing.isOpen
        piece.side.bottom.closing.isOpen = !piece.side.bottom.closing.isOpen
        
        if piece.currentSwitch == 1 {
            piece.currentSwitch = 2
        } else {
            piece.currentSwitch = 1
        }
        
        ball.piecesPassed.append(piece)
        
        delegate?.replacePiece(piece: piece)
    }
    
    
    
    func switch4Tap(piece: Piece,  completion: @escaping (Bool) -> Void) {
                
        if piece.isLocked || piece.doesPivot == false { return }
        
        print("currentSwitch before \(piece.currentSwitch)")
        
        
        if piece.currentSwitch != piece.switches {
            
            piece.currentSwitch += 1
            
        } else {
            
            piece.currentSwitch = 1
        }

        
        print("currentSwitch after \(piece.currentSwitch)")

        
        
        switch piece.shape {
        
        case .cross:
            
            piece.side.left.closing.isOpen = !piece.side.left.closing.isOpen
            piece.side.right.closing.isOpen = !piece.side.right.closing.isOpen
            piece.side.top.closing.isOpen = !piece.side.top.closing.isOpen
            piece.side.bottom.closing.isOpen = !piece.side.bottom.closing.isOpen

            
            
        case .doubleElbow:
            
            //MARK: Finish this off
            
            switch piece.version {
            
            case 1:
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = false
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "top"
                    piece.side.left.exitSide = "top"
                    piece.side.top.exitSide = "left"
                    piece.side.bottom.exitSide = nil
                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
//                    piece.side.bottom.color = piece.colors[1]
                     
//
//                    if piece.doesPivot {
//                        piece.currentSwitch = 2
//                    }
                    
                } else if piece.currentSwitch == 2 {
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = false
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "top"
                    piece.side.left.exitSide = "top"
                    piece.side.top.exitSide = "right"
                    piece.side.bottom.exitSide = nil
                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[0]
//                    piece.side.bottom.color = piece.colors[1]
                    
//                    if piece.doesPivot {
//                        piece.currentSwitch = 1
//                    }
                 }
                
            case 2:
                
                if piece.currentSwitch == 1 {
                    
                    //left bottom
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = false
                    piece.side.right.exitSide = nil
                    piece.side.left.exitSide = "bottom"
                    piece.side.top.exitSide = "left"
                    piece.side.bottom.exitSide = "left"
//                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[0]
                    
                } else if piece.currentSwitch == 2 {
                    
                    //left top
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = false
                    piece.side.right.exitSide = nil
                    piece.side.left.exitSide = "top"
                    piece.side.top.exitSide = "left"
                    piece.side.bottom.exitSide = "left"
//                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[1]
                    piece.side.bottom.color = piece.colors[0]
                    
                    
                }
                
            case 3:
                
                if piece.currentSwitch == 1 {
                    
                    //Pick up here
                    
                    //Bottom Left on top
                    piece.side.top.opening.isOpen = false
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "bottom"
                    piece.side.left.exitSide = "bottom"
                    piece.side.top.exitSide = nil
                    piece.side.bottom.exitSide = "left"
                    piece.side.right.color = piece.colors[1]
//                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[0]
                    
                } else if piece.currentSwitch == 2 {
                    
                    //Bottom right on top
                    piece.side.top.opening.isOpen = false
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "bottom"
                    piece.side.left.exitSide = "bottom"
                    piece.side.top.exitSide = nil
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.color = piece.colors[1]
//                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[1]
                    
                }
                
            case 4:
                
                
                if piece.currentSwitch == 1 {
                    
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = false
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "top"
                    piece.side.left.exitSide = nil
                    piece.side.top.exitSide = "right"
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = piece.colors[0]
//                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[1]
                    
                    
                } else if piece.currentSwitch == 2 {
                    

                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = false
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "bottom"
                    piece.side.left.exitSide = nil
                    piece.side.top.exitSide = "right"
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[0]
//                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[1]
                    
                    
                    
                 }
                
            default:
                break
            }
            
            
            
            
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
        
        print("RESET GAME")
        
        for piece in board.pieces {
            
           //UP TO HERE. MAKR THE PIECES ALL GO TO THE INDEX OF 0,0 and then delete the pieces. After this works, make it into a delegate func
            delegate?.clearPiecesAnimation(view: piece.view)
        }
        
        for ball in board.balls {
            
            ball.piecesPassed = [Piece]()
            delegate?.clearPiecesAnimation(view: ball.view)
        }
        
        board.pieces.removeAll()
        
        for ball in board.balls {
            
            delegate?.removeBall(ball: ball)
            
        }
        board.balls.removeAll()
        
        
        
        gameOver = false
        
    }
}
