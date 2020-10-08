//
//  Model.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 8/18/20.
//  Copyright © 2020 Jeffery Widroff. All rights reserved.
//

import Foundation
import UIKit

//TODO: Make the possibility for more balls
//TODO: Make the possibility for ball color-changing pieces
//TODO: change the control of the color of the pieces, entrances, exits, walls... etc to the Model
//TODO: Make sure that all piece characteristics are chosen in the model (ultimately by the level)
//TODO: Add an opening for the entrances and exits
//TODO: Give pieces the ability to rotate
//TODO: Make a piece that rotates pieces
//TODO: Make the sides of all pieces have a class like right left etc so that we can control the ball
//TODO: Make a start ball button
//TODO: Make all of the pieces move together once the start button is pressed
//TODO: make a pivot line on the pivot pieces
//TODO: Make the ball the highest on the view heirarchy

//TODO: Add number of moves left
//TODO: Make the text box for the entrance lower when the ball initially moves


protocol ModelDelegate {
    func setUpBoard(board: Board)
    func setUpPiecesView(pieces: [Piece])
    func movePieces(pieces: [Piece])
    func animatePiece(piece: Piece)
    func pieceWasTapped(piece: Piece)
    func moveBall(startIndex: Indexes, endIndex: Indexes, exitingSide: String)
}

class Model {
    
    var board = Board()
    var pieces = [Piece]()
    var level = Level()
    var walls = [Wall]()
    var delegate: ModelDelegate?
    var view = UIView()
    var entrances = [Entrance]()
    var exits = [Exit]()
    var balls = [Ball]()
    
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
        
//        let pieceLocationIndex1 = Indexes(x: 3, y: 7)
//        let pieceLocationIndex2 = Indexes(x: 1, y: 7)
//        let pieceLocationIndex3 = Indexes(x: 1, y: 4)
//        level.pieceLocations.append(pieceLocationIndex1)
//        level.pieceLocations.append(pieceLocationIndex2)
//        level.pieceLocations.append(pieceLocationIndex3)
        
        level.number = 1
        level.boardHeight = 9
        level.boardWidth = 4
        level.numberOfPieces = 10
    }
    
    func setBoard() {
        
        setupGrid()
        setupEntrances()
        setupExits()
        setupWalls()
        setupBalls()
        
        delegate?.setUpBoard(board: board)
    }
    
    
    func setupGrid() {
        
        let frameWidth = view.frame.width / 10 * 9
        let frameHeight = view.frame.height / 10 * 9
        let frameX = (view.frame.width - frameWidth) / 2
        let frameY = (view.frame.height - frameHeight) / 2
        let frame = CGRect(x: frameX, y: frameY, width: frameWidth, height: frameHeight)
        board.grid = GridPoints(frame: frame, height: level.boardHeight, width: level.boardWidth).getGrid()
    }
    
    func setupEntrances() {
        
        board.entrances = getEntrances()
    }

    func setupExits() {
        
        board.exits = getExits()
    }
    
    func setupWalls() {
        
        board.walls = getWalls()
    }
    
    func setupBalls() {
        
        for entrance in board.entrances {
            
            let ball = Ball()
            ball.indexes = entrance.indexes
            balls.append(ball)
        }
        board.balls = balls
    }
    
    func getEntrances() -> [Entrance] {
                
        
        //MARK: This needs to be set with the levelModel
        
        for _ in 1...1 {
            
            let entrance = Entrance()
            setEntranceIndex(entrance: entrance)
            entrance.opening = "bottom"
            entrances.append(entrance)
        }
        return entrances
    }
    
    func getExits() -> [Exit] {
        
        //MARK: This needs to be set with the levelModel

        for _ in 1...1 {
            
            let exit = Exit()
            setExitIndex(exit: exit)
            exit.opening = "bottom"
            exits.append(exit)
            
        }
        return exits

        
    }
    
    func getWalls() -> [Wall] {
        
        
        for _ in 0...2 {

            let wall = Wall()
            setWallIndex(wall: wall)
            walls.append(wall)
        }
        return walls
    }
    
    func setPieces() {
        
        //MARK: SET PIECE SIDES HERE
        
        
        for _ in 0..<level.numberOfPieces {
            
            let piece = Piece()
            setPieceIndex(piece: piece)
            setPieceShape(piece: piece)
            setPieceColor(piece: piece)
            setPieceOpacity(piece: piece)
            setPieceSwitches(piece: piece)
            setPieceSides(piece: piece)
            pieces.append(piece)
            
        }
        delegate?.setUpPiecesView(pieces: pieces)
    }
    
    func setPieceSides(piece: Piece) {
        
        //TODO: Make it that the pieces sides being open are not true and false but rather another side that the piece leads to and if the other side is nil, then the side is obviously closed - that way we know #1 which way to send the ball and #2 to determine if the ball can even go through the tube. Also get rid of the unnecessary pieces added for the side.
        
        
        
        
        
        switch piece.shape {
            
        case .elbow:
            
            //TODO: Make this conditional on the pieces way that its rotated

            
            piece.side.top.opening.isOpen = true
            piece.side.left.opening.isOpen = true
            piece.side.top.closing.isOpen = true
            piece.side.left.closing.isOpen = true
            
            piece.side.top.exitSide = "left"
            piece.side.left.exitSide = "top"

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
            
            piece.side.right.exitSide = "top"
            piece.side.left.exitSide = "bottom"
            piece.side.top.exitSide = "right"
            piece.side.bottom.exitSide = "left"
            
            
            
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
        if pieces.contains(where: { (pieceX) -> Bool in
            pieceX.indexes == index
        }) || board.walls.contains(where: { (wall) -> Bool in
            wall.indexes == index
        }) || board.entrances.contains(where: { (entrance) -> Bool in
            entrance.indexes == index
        }) || board.exits.contains(where: { (exit) -> Bool in
            exit.indexes == index
        }){
            setPieceIndex(piece: piece)
        } else {
            piece.indexes = index
        }
    }
    
    func setWallIndex(wall: Wall) {
        
        let index = Indexes(x: Int(arc4random_uniform(UInt32(level.boardWidth))), y: Int(arc4random_uniform(UInt32(level.boardHeight))))
        
        if walls.contains(where: { (wallX) -> Bool in
            wallX.indexes == index
        }) || board.entrances.contains(where: { (entrance) -> Bool in
            entrance.indexes == index
        }) || board.exits.contains(where: { (exit) -> Bool in
            exit.indexes == index
        }){
            setWallIndex(wall: wall)
        } else {
            wall.indexes = index
        }
    }
    
    func setExitIndex(exit: Exit) {
        
        let index = Indexes(x: Int(arc4random_uniform(UInt32(level.boardWidth))), y: Int(arc4random_uniform(UInt32(level.boardHeight))))
        
        if exits.contains(where: { (exit) -> Bool in
            exit.indexes == index
        }) || board.entrances.contains(where: { (entrance) -> Bool in
            entrance.indexes == index
        }){
            setExitIndex(exit: exit)
        } else {
            exit.indexes = index
        }
    }
    
    func setEntranceIndex(entrance: Entrance) {
        
        let index = Indexes(x: Int(arc4random_uniform(UInt32(level.boardWidth))), y: Int(arc4random_uniform(UInt32(level.boardHeight))))
        
        if entrances.contains(where: { (entrance) -> Bool in
            entrance.indexes == index
        }) {
            setEntranceIndex(entrance: entrance)
        } else {
            entrance.indexes = index
        }
    }
    
    
    
    func setPieceShape(piece: Piece) {
        
        let randomShapes:[Shape] = [.elbow, .doubleElbow, .cross, .quadBox, .diagElbow]//, "sword"]

        piece.shape = randomShapes[Int(arc4random_uniform(UInt32(randomShapes.count)))]
    }
    
    func setPieceColor(piece: Piece) {
        let randomColors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.white, UIColor.purple, UIColor.cyan, UIColor.yellow, UIColor.orange]
        piece.color = randomColors[Int(arc4random_uniform(UInt32(randomColors.count)))]
    }
    
    func setPieceOpacity(piece: Piece) {
        piece.opacity = 1 //Int(arc4random_uniform(UInt32(3))) + 1
    }
    
    func isNextSpaceBlocked(direction: UISwipeGestureRecognizer.Direction, indexes: Indexes) -> Bool {
        
        var bool = true

        switch direction {
        case .up:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
            }) || board.walls.contains(where: { (wall) -> Bool in
                wall.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
            }) || board.entrances.contains(where: { (entrance) -> Bool in
                entrance.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
            }) || board.exits.contains(where: { (exit) -> Bool in
                exit.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
            }) {
                bool = false
            }
            
            
        case .down:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! + 1)
            }) || board.walls.contains(where: { (wall) -> Bool in
                wall.indexes == Indexes(x: indexes.x, y: indexes.y! + 1)
            }) || board.entrances.contains(where: { (entrance) -> Bool in
                entrance.indexes == Indexes(x: indexes.x, y: indexes.y! + 1)
            }) || board.exits.contains(where: { (exit) -> Bool in
                exit.indexes == Indexes(x: indexes.x, y: indexes.y! + 1)
            }) {
                bool = false
            }
            
        case .left:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! - 1, y: indexes.y)
            }) || board.walls.contains(where: { (wall) -> Bool in
                wall.indexes == Indexes(x: indexes.x! - 1, y: indexes.y)
            }) || board.entrances.contains(where: { (entrance) -> Bool in
                entrance.indexes == Indexes(x: indexes.x! - 1, y: indexes.y)
            }) || board.exits.contains(where: { (exit) -> Bool in
                exit.indexes == Indexes(x: indexes.x! - 1, y: indexes.y)
            }) {
                bool = false
            }
            
        case .right:
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! + 1, y: indexes.y)
            }) || board.walls.contains(where: { (wall) -> Bool in
                wall.indexes == Indexes(x: indexes.x! + 1, y: indexes.y)
            }) || board.entrances.contains(where: { (entrance) -> Bool in
                entrance.indexes == Indexes(x: indexes.x! + 1, y: indexes.y)
            }) || board.exits.contains(where: { (exit) -> Bool in
                exit.indexes == Indexes(x: indexes.x! + 1, y: indexes.y)
            }) {
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
                    return int1 < int2
                })
                if notAtWall {
                    if spaceIsntBlocked{
                        piece.indexes.y = piece.indexes.y! + 1
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
                    return int1 < int2
                })
                if notAtWall {
                    if spaceIsntBlocked {
                        piece.indexes.x = piece.indexes.x! + 1
                    }
                }
            }
            delegate?.movePieces(pieces: pieces)

        default:
            break
        }
    }
    
    func switchPieces(piece: Piece) {
        
        piece.switch4Tap()
        
        switch piece.shape {
            
        case .elbow:
            
            
            if piece.currentSwitch == 1 {
                
                piece.side.top.exitSide = "left"
                piece.side.left.exitSide = "top"
                piece.side.right.exitSide = nil
                
            } else if piece.currentSwitch == 2 {

                piece.side.top.exitSide = "right"
                piece.side.right.exitSide = "top"
                piece.side.left.exitSide = nil
            }
            
            piece.side.left.opening.isOpen = !piece.side.left.opening.isOpen
            piece.side.right.opening.isOpen = !piece.side.right.opening.isOpen
            piece.side.left.closing.isOpen = !piece.side.left.closing.isOpen
            piece.side.right.closing.isOpen = !piece.side.right.closing.isOpen
            
        case .doubleElbow:
            
            if piece.currentSwitch == 1 {
                
                piece.side.top.exitSide = "right"
                piece.side.right.exitSide = "top"
                piece.side.left.exitSide = nil
                
            } else if piece.currentSwitch == 2 {

                piece.side.top.exitSide = "left"
                piece.side.left.exitSide = "top"
                piece.side.right.exitSide = nil

            }
            
            
            piece.side.left.closing.isOpen = !piece.side.left.closing.isOpen
            piece.side.right.closing.isOpen = !piece.side.right.closing.isOpen
            
            
            
            
        case .quadBox: // Nothing to set as far as openings and closings

            
            if piece.currentSwitch == 1 {
                
                piece.side.top.exitSide = "left"
                piece.side.left.exitSide = "top"
                piece.side.bottom.exitSide = "right"
                piece.side.right.exitSide = "bottom"
                
            } else if piece.currentSwitch == 2 {

                piece.side.top.exitSide = "right"
                piece.side.right.exitSide = "top"
                piece.side.bottom.exitSide = "left"
                piece.side.left.exitSide = "bottom"

            }
            
            
            
        case .cross:

           if piece.currentSwitch == 1 {
        
            piece.side.right.exitSide = "left"
            piece.side.left.exitSide = "right"
            
           } else if piece.currentSwitch == 2 {

            piece.side.top.exitSide = "bottom"
            piece.side.bottom.exitSide = "top"

           }
            
            piece.side.left.closing.isOpen = !piece.side.left.closing.isOpen
            piece.side.right.closing.isOpen = !piece.side.right.closing.isOpen
            piece.side.top.closing.isOpen = !piece.side.top.closing.isOpen
            piece.side.bottom.closing.isOpen = !piece.side.bottom.closing.isOpen
            
            
            
        case .sword:
            print("TODO - Set this")

            
        case .diagElbow: // Nothing to set as far as openings and closings
                    
            
            
            if piece.currentSwitch == 1 {
            
                piece.side.right.exitSide = "top"
                piece.side.left.exitSide = "bottom"
                piece.side.top.exitSide = "right"
                piece.side.bottom.exitSide = "left"
                
            } else if piece.currentSwitch == 2 {
                
                piece.side.top.exitSide = "left"
                piece.side.left.exitSide = "top"
                piece.side.bottom.exitSide = "right"
                piece.side.right.exitSide = "bottom"
                
            }
            
        default:
            break
        }
        
    }
    
    func moveBall(ball: Ball) {
                                
        for entrance in entrances {
            
            let startIndex = ball.indexes
            let endIndex: Indexes?
            
            
            print("moving out of entrance")

            
            switch entrance.opening {
                
            
            
            case "top":
                
                print("moving out of top of entrance")
                
                
                let ballCanMove = checkIfBallCanMove(direction: .up, indexes: ball.indexes)

                if ballCanMove {
                                        
                    print("Y index went down because we moved up")
                    
                    endIndex = Indexes(x: ball.indexes.x, y: ball.indexes.y! - 1)
                    
                    delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: "top")
                    ball.indexes = endIndex!
                }
                
                
            case "bottom":
                
                print("moving out of bottom of entrance")

                
                let ballCanMove = checkIfBallCanMove(direction: .down, indexes: ball.indexes)

                if ballCanMove {
                    
                    print("Y index went up because we moved down")
                                        
                    endIndex = Indexes(x: ball.indexes.x, y: ball.indexes.y! + 1)
                    
                    delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: "bottom")
                    ball.indexes = endIndex!
                }
                
                
            case "left":
                
                print("moving out of left of entrance")

                
                let ballCanMove = checkIfBallCanMove(direction: .left, indexes: ball.indexes)

                if ballCanMove {
                          
                    print("X index went down because we moved left")
                    
                    endIndex = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y)

                    delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: "left")
                    ball.indexes = endIndex!
                }
                
            case "right":
                
                print("moving out of right of entrance")

                
                let ballCanMove = checkIfBallCanMove(direction: .right, indexes: ball.indexes)

                if ballCanMove {
                            
                    print("X index went up because we moved right")

                    
                    
                    endIndex = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y)

                    delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: "right")
                    ball.indexes = endIndex!
                }
                
                
            default:
                break
            }
            
        }
        
    }
    
    
    func moveBallAgain(ball: Ball, enteringSide: String) {
        
        
        let startIndex = ball.indexes
        var endIndex: Indexes?
        var side = String()
        
        print("entered new piece on \(enteringSide) as expected")
        
        
        for piece in pieces {
            
            if ball.indexes == piece.indexes {
                  
                if enteringSide == "left" {
                    
                    print("entered piece on the left")
                                        
                    if piece.side.left.exitSide == "right" {
                        
                        print("the pieces exit side is on the right")
                        
                        endIndex = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y)
                        side = piece.side.left.exitSide! // FIX
                        delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: side)
                        
                        ball.indexes = endIndex!
                        
                    } else if piece.side.left.exitSide == "top" {

                        print("the pieces exit side is on the top")

                        endIndex = Indexes(x: ball.indexes.x, y: ball.indexes.y! - 1)
                        side = piece.side.left.exitSide! // FIX
                        delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: side)
                        ball.indexes = endIndex!
                        
                    } else if piece.side.left.exitSide == "bottom" {
                        
                        print("the pieces exit side is on the bottom")

                        endIndex = Indexes(x: ball.indexes.x, y: ball.indexes.y! + 1)
                        side = piece.side.left.exitSide! // FIX
                        delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: side)
                        ball.indexes = endIndex!
                    }
                    
                } else if enteringSide == "right" {
                    
                    print("entered piece on the right")

                    
                    if piece.side.right.exitSide == "left" {
                        
                        print("the pieces exit side is on the left")

                        endIndex = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y)
                        side = piece.side.right.exitSide! // FIX
                        delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: side)
                        ball.indexes = endIndex!

                    } else if piece.side.right.exitSide == "top" {
                        
                        print("the pieces exit side is on the top")

                        endIndex = Indexes(x: ball.indexes.x, y: ball.indexes.y! - 1)
                        side = piece.side.right.exitSide! // FIX
                        delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: side)
                        ball.indexes = endIndex!
                        
                    } else if piece.side.right.exitSide == "bottom" {
                        
                        print("the pieces exit side is on the bottom")

                        endIndex = Indexes(x: ball.indexes.x, y: ball.indexes.y! + 1)
                        side = piece.side.right.exitSide! // FIX
                        delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: side)
                        ball.indexes = endIndex!
                    }
                    
                } else if enteringSide == "top" {
                    
                    print("entered piece on the top")

                    
                    if piece.side.top.exitSide == "bottom" {
                        
                        print("the pieces exit side is on the bottom")

                        endIndex = Indexes(x: ball.indexes.x, y: ball.indexes.y! + 1)
                        side = piece.side.top.exitSide! // FIX
                        delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: side)
                        ball.indexes = endIndex!
                        
                    } else if piece.side.top.exitSide == "left" {
                        
                        print("the pieces exit side is on the left")

                        endIndex = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y)
                        side = piece.side.top.exitSide! // FIX
                        delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: side)
                        ball.indexes = endIndex!
                        
                    } else if piece.side.top.exitSide == "right" {
                        
                        print("the pieces exit side is on the right")

                        endIndex = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y)
                        side = piece.side.top.exitSide! // FIX
                        delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: side)
                        ball.indexes = endIndex!
                    }
                    
                } else if enteringSide == "bottom" {
                    
                    print("entered piece on the bottom")

                    if piece.side.bottom.exitSide == "top" {
                        
                        print("the pieces exit side is on the top")

                        endIndex = Indexes(x: ball.indexes.x, y: ball.indexes.y! - 1)
                        side = piece.side.bottom.exitSide! // FIX
                        delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: side)
                        ball.indexes = endIndex!
                        
                    } else if piece.side.bottom.exitSide == "left" {
                        
                        print("the pieces exit side is on the left")

                        endIndex = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y)
                        side = piece.side.bottom.exitSide! // FIX
                        delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: side)
                        ball.indexes = endIndex!
                        
                    } else if piece.side.bottom.exitSide == "right" {
                        
                        print("the pieces exit side is on the right")

                        endIndex = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y)
                        side = piece.side.bottom.exitSide! // FIX
                        delegate?.moveBall(startIndex: startIndex, endIndex: endIndex!, exitingSide: side)
                        ball.indexes = endIndex!
                    }
                    
                }
                return
                                
            }
            
        }
        
    }
    
    
    
    
    
    
    func checkIfBallCanMove(direction: UISwipeGestureRecognizer.Direction, indexes: Indexes) -> Bool {
        
        var bool = Bool()

        switch direction {
            
        case .up:
            
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! - 1) && piece.side.bottom.opening.isOpen == true
            }) {
                bool = true
            } else {
                bool = false
            }
            
//            if board.walls.contains(where: { (wall) -> Bool in
//                wall.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
//            }) || board.entrances.contains(where: { (entrance) -> Bool in
//                entrance.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
//            }) || board.exits.contains(where: { (exit) -> Bool in
//                exit.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
//            }) || pieces.contains(where: { (piece) -> Bool in
//                piece.indexes == Indexes(x: indexes.x, y: indexes.y! - 1) && piece.side.bottom.opening.isOpen == false
//            }){
//                bool = false
//            }
            
            
        case .down:
            
            
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! + 1) && piece.side.top.opening.isOpen == true
            }) {
                bool = true
            } else {
                bool = false
            }
            
            
            
//            if board.walls.contains(where: { (wall) -> Bool in
//                wall.indexes == Indexes(x: indexes.x, y: indexes.y! + 1)
//            }) || board.entrances.contains(where: { (entrance) -> Bool in
//                entrance.indexes == Indexes(x: indexes.x, y: indexes.y! + 1)
//            }) || board.exits.contains(where: { (exit) -> Bool in
//                exit.indexes == Indexes(x: indexes.x, y: indexes.y! + 1)
//            }) || pieces.contains(where: { (piece) -> Bool in
//                piece.indexes == Indexes(x: indexes.x, y: indexes.y! + 1) && piece.side.top.opening.isOpen == false
//            }) {
//                bool = false
//            }
            
        case .left:
            
            
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! - 1, y: indexes.y) && piece.side.right.opening.isOpen == true
            }) {
                bool = true
            } else {
                bool = false
            }
            
            
//            if board.walls.contains(where: { (wall) -> Bool in
//                wall.indexes == Indexes(x: indexes.x! - 1, y: indexes.y)
//            }) || board.entrances.contains(where: { (entrance) -> Bool in
//                entrance.indexes == Indexes(x: indexes.x! - 1, y: indexes.y)
//            }) || board.exits.contains(where: { (exit) -> Bool in
//                exit.indexes == Indexes(x: indexes.x! - 1, y: indexes.y)
//            }) || pieces.contains(where: { (piece) -> Bool in
//                piece.indexes == Indexes(x: indexes.x! - 1, y: indexes.y) && piece.side.right.opening.isOpen == false
//            }) {
//                bool = false
//            }
            
        case .right:
            
            if pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! + 1, y: indexes.y) && piece.side.left.opening.isOpen == true
            }) {
                bool = true
            } else {
                bool = false
            }
            
            
            
            
//            if board.walls.contains(where: { (wall) -> Bool in
//                wall.indexes == Indexes(x: indexes.x! + 1, y: indexes.y)
//            }) || board.entrances.contains(where: { (entrance) -> Bool in
//                entrance.indexes == Indexes(x: indexes.x! + 1, y: indexes.y)
//            }) || board.exits.contains(where: { (exit) -> Bool in
//                exit.indexes == Indexes(x: indexes.x! + 1, y: indexes.y)
//            }) || pieces.contains(where: { (piece) -> Bool in
//                piece.indexes == Indexes(x: indexes.x! + 1, y: indexes.y) && piece.side.left.opening.isOpen == false
//            }) {
//                bool = false
//            }
        default:
            break
        }
        return bool
    }
    
    
    func handleTap(center: CGPoint) {
                
        for piece in pieces {
            
            
            if board.grid[piece.indexes] == center {
                
                switchPieces(piece: piece)
                
                delegate?.pieceWasTapped(piece: piece)
            }
        }
        
        for ball in balls {
            
            print("begin was tapped. Moving ball now \(balls.count)")
            
            if board.grid[ball.indexes] == center {
                
                
                moveBall(ball: ball)
                
            }
        }
    }
}
