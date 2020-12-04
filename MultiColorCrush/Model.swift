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

//TODO: Make a piece that changes the balls color
//TODO: Make it that the variables of each piece can be set on their own and create a level model
//TODO: Make it that the pieces switch (if they have a switch) after the ball passes

//TODO: Make it that the entrances cant open next to a wall
//TODO: Add place that pieces get added from (in higher levels)
//TODO: Make a retry button

//TODO: Make a better lock - Something like making it look like the pieces are screwed in each corner
//TODO: Make a pieceMaker view
//TODO: Fix the way the walls look
//TODO: Fix how ICE looks
//TODO: Make black border around pieces

//TODO: Make sure that walls cant be on ice and that entrances, exits, walls and other such things are unable to be added on top of eachother

//TODO: Add number of moves left
//TODO: Make the text box for the entrance lower when the ball initially moves


protocol ModelDelegate {
    func setUpGame(board: Board)
    func setUpPiecesView()
    func movePieces()
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
        
        
        level.iceLocations = [Indexes(x: 2, y: 2), Indexes(x: 2, y: 1)]
        level.pieceMakerLocations = [Indexes(x: 4, y: 4)]
        level.number = 1
        level.boardHeight = 10
        level.boardWidth = 5
        level.numberOfPieces = 20
    }
    
    func setBoard() {
        
        setupIce()
        
        delegate?.setUpGame(board: board)
    }
    
    func setupPieceMakers() {
        
        for _ in 1...1 {
            
            let pieceMaker = Piece()
            setPieceIndex(piece: pieceMaker)
            pieceMaker.isLocked = true
            pieceMaker.colors = [.yellow]
            pieceMaker.side.bottom.opening.isOpen = true
            pieceMaker.shape = .pieceMaker
            
            let version = Int(arc4random_uniform(UInt32(4))) + 1
            pieceMaker.version = version
            
            let randomColors:[UIColor] = [UIColor.red, UIColor.blue]//, UIColor.green, UIColor.purple, UIColor.yellow, UIColor.orange]//, UIColor.white, UIColor.cyan]
            let randomColor1 = randomColors[Int(arc4random_uniform(UInt32(randomColors.count)))]
            let randomColor2 = randomColors[Int(arc4random_uniform(UInt32(randomColors.count)))]
            
            pieceMaker.nextPiece.colors = [randomColor1, randomColor2]
            
            
            let nextPieceVersion = Int(arc4random_uniform(UInt32(4))) + 1
            pieceMaker.nextPiece.version = nextPieceVersion
            let randomShapes:[Shape] = [.stick, .diagElbow, .cross, .elbow]// .doubleElbow, .quadBox, .diagElbow]//, "sword"]
           
            pieceMaker.nextPiece.shape = randomShapes[Int(arc4random_uniform(UInt32(randomShapes.count)))]
            
            
            
            switch pieceMaker.nextPiece.shape {
            
            case .elbow:
//                pieceMaker.nextPiece.switches = 2
                pieceMaker.nextPiece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
                
            case .diagElbow:
                
//                pieceMaker.nextPiece.switches = 2
                pieceMaker.nextPiece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
                
            case .cross:
                
//                pieceMaker.nextPiece.switches = 2
                pieceMaker.nextPiece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
                
                
            case .stick:
                
//                pieceMaker.nextPiece.switches = 1
                pieceMaker.nextPiece.currentSwitch = Int(arc4random_uniform(UInt32(1))) + 1
                
                
            default:
                break
            }
            
            
            
            
            
            
            
            //TODO: COntinue here finishing adding the nextPiece properties (see nextpiece class)
            
            
            board.pieces.append(pieceMaker)
            
        }
    }
    
    func setupIce() {
        
        board.iceLocations = level.iceLocations
    }
    
    
    func setupEntrances() {
        
//        for _ in 1...1 {
//
//            let entrance = Entrance()
//            setPieceIndex(piece: entrance)
//            entrance.isLocked = true
//            entrance.colors = [.black]
//            entrance.opening = "top"
//            board.pieces.append(entrance)
//        }
        
        for _ in 1...1 {
            
            
            //White box with lock
            
            let entrance = Piece()
            setPieceIndex(piece: entrance)
            entrance.isLocked = true
            entrance.colors = [.red]
            entrance.opening = "top"
            entrance.shape = .entrance
            board.pieces.append(entrance)
        }
        
        
        
    }

    func setupExits() {
        
//        for _ in 1...1 {
//
//            let exit = Exit()
//            setPieceIndex(piece: exit)
//            exit.colors = [.black]
//            exit.isLocked = true
//            exit.opening = "bottom"
//            board.pieces.append(exit)
//        }
        
        for _ in 1...1 {
            
            
            //brown box with lock
            
            let exit = Piece()
            setPieceIndex(piece: exit)
            exit.isLocked = true
            exit.colors = [.red]
            exit.opening = "left"
            exit.shape = .exit
            board.pieces.append(exit)
        }
        
        
    }
    
    func setupWalls() {
        
        for _ in 0...0 {

            let wall = Piece()
            setPieceIndex(piece: wall)
            wall.isLocked = true
            wall.colors = [.lightGray]
            wall.shape = .wall
            board.pieces.append(wall)
        }
    }
    
    func setupBalls() {
        
        for piece in board.pieces {
            
            if piece.shape == .entrance {

            
            let ball = Ball()
                ball.indexes = piece.indexes
                board.balls.append(ball)
            }
        }
        board.balls = board.balls
    }
    
    func setPieces() {
        
        setupPieceMakers()
        setupEntrances()
        setupExits()
        setupWalls()
        setupBalls()
        
        
        for _ in 0..<level.numberOfPieces {
            
            let piece = Piece()
            setPieceIndex(piece: piece)
            setPieceShape(piece: piece)
            setPieceColor(piece: piece)
            setPieceSwitches(piece: piece)
            setPieceSides(piece: piece)
            
            
            printPieceProperties(piece: piece)
            
            
            //Print all properties of each piece and see if the pieces side colors were set correctly
            //Consider putting all info for sides in the setPieceSides func
            
            
            
            
            
            board.pieces.append(piece)
        }
        delegate?.setUpPiecesView()
    }
    
    func printPieceProperties(piece: Piece) {
        
//        print("shape \(piece.shape)")
//        print("version \(piece.version)")
//        print("switch \(piece.currentSwitch)")


        
//        print("piece left side exitSide \(piece.side.left.exitSide)")
//        print("piece right side exitSide \(piece.side.right.exitSide)")
//        print("piece top side exitSide \(piece.side.top.exitSide)")
//        print("piece bottom side exitSide \(piece.side.bottom.exitSide)")
        
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
                
                //Top Pivot
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.top.closing.isOpen = true
                    piece.side.left.closing.isOpen = true
                    
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
                    piece.side.top.closing.isOpen = true
                    piece.side.right.closing.isOpen = true
                    
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
                    piece.side.bottom.closing.isOpen = true
                    piece.side.left.closing.isOpen = true
                    
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
                    piece.side.top.closing.isOpen = true
                    piece.side.left.closing.isOpen = true
                    
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
                    piece.side.bottom.closing.isOpen = true
                    piece.side.right.closing.isOpen = true
                    
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
                    piece.side.bottom.closing.isOpen = true
                    piece.side.left.closing.isOpen = true
                    
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
                    piece.side.top.closing.isOpen = true
                    piece.side.right.closing.isOpen = true
                    
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
                    piece.side.bottom.closing.isOpen = true
                    piece.side.right.closing.isOpen = true
                    
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.exitSide = "bottom"
                    piece.side.top.exitSide = nil
                    piece.side.left.exitSide = nil
                    
                    piece.side.left.color = piece.colors[0]
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = nil
                    piece.side.bottom.color = nil
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
                    
                    piece.side.left.closing.isOpen = true
                    piece.side.right.closing.isOpen = true
                    piece.side.top.closing.isOpen = false
                    piece.side.bottom.closing.isOpen = false
                    
                } else if piece.currentSwitch == 2 {
                    
                    piece.side.left.closing.isOpen = false
                    piece.side.right.closing.isOpen = false
                    piece.side.top.closing.isOpen = true
                    piece.side.bottom.closing.isOpen = true
                    
                    
                }
                
                
            case 2, 4:
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.left.closing.isOpen = false
                    piece.side.right.closing.isOpen = false
                    piece.side.top.closing.isOpen = true
                    piece.side.bottom.closing.isOpen = true
                    
                } else if piece.currentSwitch == 2 {
                    
                    piece.side.left.closing.isOpen = true
                    piece.side.right.closing.isOpen = true
                    piece.side.top.closing.isOpen = false
                    piece.side.bottom.closing.isOpen = false
                    
                    
                }
                
            default:
                break
            }
            
            
            
        case .stick:
            
           
            switch piece.version {
            case 1, 3:
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.left.closing.isOpen = true
                    piece.side.right.closing.isOpen = true
                    piece.side.right.exitSide = "left"
                    piece.side.left.exitSide = "right"
                    piece.side.right.color = piece.colors[1]
                    piece.side.left.color = piece.colors[1]
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    
                } else if piece.currentSwitch == 2 {
                    
                    piece.side.top.closing.isOpen = true
                    piece.side.bottom.closing.isOpen = true
                    piece.side.top.exitSide = "bottom"
                    piece.side.bottom.exitSide = "top"
                    piece.side.top.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    
                    
                }
                
                
            case 2, 4:
                
                if piece.currentSwitch == 1 {
                    
                   
                    piece.side.top.closing.isOpen = true
                    piece.side.bottom.closing.isOpen = true
                    piece.side.top.exitSide = "bottom"
                    piece.side.bottom.exitSide = "top"
                    piece.side.top.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    
                } else if piece.currentSwitch == 2 {
                    
                    piece.side.left.closing.isOpen = true
                    piece.side.right.closing.isOpen = true
                    piece.side.right.exitSide = "left"
                    piece.side.left.exitSide = "right"
                    piece.side.right.color = piece.colors[1]
                    piece.side.left.color = piece.colors[1]
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    
                    
                }
                
            default:
                break
            }
            
            
            
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
            
            piece.switches = 2
            piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
            
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
        let randomShapes:[Shape] = [.stick, .diagElbow, .cross, .elbow]// .doubleElbow, .quadBox, .diagElbow]//, "sword"]
        piece.shape = randomShapes[Int(arc4random_uniform(UInt32(randomShapes.count)))]
    }
    
    func setPieceColor(piece: Piece) {
        
        let randomColors:[UIColor] = [UIColor.red, UIColor.blue]//, UIColor.green, UIColor.purple, UIColor.yellow, UIColor.orange]//, UIColor.white, UIColor.cyan]
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
                
                print("piece found index = \(piece.indexes)")
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

//        print("BOOL IS \(bool)")
        
        
        return bool

    }
    
    func movePiecesHelper(piece: Piece, direction: UISwipeGestureRecognizer.Direction) {
       
        
        switch direction {
        
        case .up:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .up, indexes: piece.indexes)
            
            let notAtWall = piece.indexes.y != 0
            if notAtWall {
                if spaceIsntBlocked {
                    piece.indexes.y = piece.indexes.y! - 1
                    if checkForIce(piece: piece) == true {
                        movePiecesHelper(piece: piece, direction: direction)
                    }
                }
            }
           
        case .down:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .down, indexes: piece.indexes)
            
            let notAtWall = piece.indexes.y != board.grid.keys.map({$0.y!}).max(by: { (int1, int2) -> Bool in
                return int1 < int2
            })
            if notAtWall {
                if spaceIsntBlocked{
                    piece.indexes.y = piece.indexes.y! + 1
                    if checkForIce(piece: piece) == true {
                        movePiecesHelper(piece: piece, direction: direction)
                    }
                }
            }
            
            
            
        case .left:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .left, indexes: piece.indexes)
            let notAtWall = piece.indexes.x != 0
            if notAtWall {
                if spaceIsntBlocked {
                    piece.indexes.x = piece.indexes.x! - 1
                    if checkForIce(piece: piece) == true {
                        movePiecesHelper(piece: piece, direction: direction)
                    }
                }
            }
            
            
            
        case .right:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .right, indexes: piece.indexes)
            let notAtWall = piece.indexes.x != board.grid.keys.map({$0.x!}).max(by: { (int1, int2) -> Bool in
                return int1 < int2
            })
            if notAtWall {
                if spaceIsntBlocked {
                    piece.indexes.x = piece.indexes.x! + 1
                    if checkForIce(piece: piece) == true {
                        movePiecesHelper(piece: piece, direction: direction)
                    }
                }
            }
            
            
            
        default:
            break
        }
        
        
        
        
        
    }
    
    
    func movePiece(direction: UISwipeGestureRecognizer.Direction) {
        
        switch direction {
            
        case .up:
                        
            for piece in board.pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.y! < piece2.indexes.y!
            }).filter({ (piece) -> Bool in
                piece.isLocked == false
            }) {
                
                movePiecesHelper(piece: piece, direction: direction)
//                let spaceIsntBlocked = isNextSpaceBlocked(direction: .up, indexes: piece.indexes)
//                let notAtWall = piece.indexes.y != 0
//                if notAtWall {
//                    if spaceIsntBlocked {
//                        piece.indexes.y = piece.indexes.y! - 1
//                        if checkForIce(piece: piece) == true {
//                            movePiece(direction: direction)
//                        }
//
//                    }
//                }
            }
            delegate?.movePieces()

        case .down:
            for piece in board.pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.y! > piece2.indexes.y!
                
            }).filter({ (piece) -> Bool in
                piece.isLocked == false
            })  {
                
                movePiecesHelper(piece: piece, direction: direction)

//                let spaceIsntBlocked = isNextSpaceBlocked(direction: .down, indexes: piece.indexes)
//
//                let notAtWall = piece.indexes.y != board.grid.keys.map({$0.y!}).max(by: { (int1, int2) -> Bool in
//                    return int1 < int2
//                })
//                if notAtWall {
//                    if spaceIsntBlocked{
//                        piece.indexes.y = piece.indexes.y! + 1
//                        if checkForIce(piece: piece) == true {
//                            movePiece(direction: direction)
//                        }
//                    }
//                }
            }
            delegate?.movePieces()

        case .left:
            for piece in board.pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.x! < piece2.indexes.x!
            }).filter({ (piece) -> Bool in
                piece.isLocked == false
            })  {
                
                movePiecesHelper(piece: piece, direction: direction)

//                let spaceIsntBlocked = isNextSpaceBlocked(direction: .left, indexes: piece.indexes)
//                let notAtWall = piece.indexes.x != 0
//                if notAtWall {
//                    if spaceIsntBlocked {
//                        piece.indexes.x = piece.indexes.x! - 1
//                        if checkForIce(piece: piece) == true {
//                            movePiece(direction: direction)
//                        }
//                    }
//                }
            }
            delegate?.movePieces()

        case .right:
            for piece in board.pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.x! > piece2.indexes.x!
            }).filter({ (piece) -> Bool in
                piece.isLocked == false
            })  {
                
                movePiecesHelper(piece: piece, direction: direction)

//                let spaceIsntBlocked = isNextSpaceBlocked(direction: .right, indexes: piece.indexes)
//                let notAtWall = piece.indexes.x != board.grid.keys.map({$0.x!}).max(by: { (int1, int2) -> Bool in
//                    return int1 < int2
//                })
//                if notAtWall {
//                    if spaceIsntBlocked {
//                        piece.indexes.x = piece.indexes.x! + 1
//                        if checkForIce(piece: piece) == true {
//                            movePiece(direction: direction)
//                        }
//                    }
//                }
            }
            delegate?.movePieces()

        default:
            break
        }
    }
        
    func moveBall(ball: Ball, startSide: String) {
        
        switch startSide {
        
        case "unmoved":
            
            let piece = getPieceInfo(index: ball.indexes)
            let startSide = "center"
            let endSide = piece.opening
            
            
            
//            if piece.side.top.opening.isOpen == true {
//                endSide = "top"
//            } else if piece.side.bottom.opening.isOpen == true {
//                endSide = "bottom"
//            } else if piece.side.left.opening.isOpen == true {
//                endSide = "left"
//            } else if piece.side.right.opening.isOpen == true {
//                endSide = "right"
//            }
            
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
                    
                    //TODO: Change this back
                    piece.view.isUserInteractionEnabled = false
                }
                
                board.view.isUserInteractionEnabled = false
                
                moveBall(ball: ball, startSide: "unmoved")
            }
        }
    }
}
