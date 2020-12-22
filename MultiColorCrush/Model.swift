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

//TODO: Make the pieces have a PATH? var and use it only once instead of all the times it's being used

//TODO: Make it that the balls follow the entrances when they move


protocol ModelDelegate {
    func setUpGame(board: Board)
    func setUpPiecesView()
    func movePieces(direction: UISwipeGestureRecognizer.Direction)
    func pieceWasTapped(piece: Piece)
    func moveBallView(ball: Ball, piece: Piece, startSide: String, endSide: String)
    func addPieceView(piece: Piece)
    func resetPieceMaker(piece: Piece)
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
        self.board = levelModel.returnBoard(levelNumber: 1)
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
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.right.exitSide = "left"
                    piece.side.left.exitSide = "right"
                    piece.side.right.color = piece.colors[1]
                    piece.side.left.color = piece.colors[1]
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    
                } else if piece.currentSwitch == 2 {
                    
                    piece.side.top.exitSide = "bottom"
                    piece.side.bottom.exitSide = "top"
                    piece.side.top.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                }
                
            case 2, 4:
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.top.exitSide = "bottom"
                    piece.side.bottom.exitSide = "top"
                    piece.side.top.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    
                } else if piece.currentSwitch == 2 {
                    
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
            
            let notAtWall = piece.indexes.y != 0
            
            if notAtWall {
                
                if spaceIsntBlocked {
                                        
                    if piece.shape != .pieceMaker {
                        
                        if piece.isLocked == false {
                            
                            piece.indexes.y = piece.indexes.y! - 1
                            
                            if checkForIce(piece: piece) == true {
                                
                                movePiecesHelper(piece: piece, direction: direction)
                            }
                        }
                        
                    } else {
                        
                        if piece.shape == .pieceMaker && piece.version == 3 {
                                                        
                            if piece.nextPiece != nil {
                                
                                let newPiece = piece.nextPiece!
                                
                                newPiece.view = ShapeView(frame: piece.view.frame, piece: newPiece)
                                                                
                                delegate?.addPieceView(piece: newPiece)
                                
                                board.pieces.append(newPiece)
                                
                                newPiece.indexes.y = newPiece.indexes.y! - 1
                                
                                if checkForIce(piece: newPiece) == true {
                                    
                                    movePiecesHelper(piece: newPiece, direction: direction)
                                }
                                
                                resetPieceMaker(piece: piece)
                            }
                        }
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
                    
                    if piece.shape != .pieceMaker {
                        
                        if piece.isLocked == false {
                            
                            piece.indexes.y = piece.indexes.y! + 1
                            
                            if checkForIce(piece: piece) == true {
                                
                                movePiecesHelper(piece: piece, direction: direction)
                            }
                        }
                        
                    } else {
                        
                        if piece.shape == .pieceMaker && piece.version == 1 {
                            
                            if piece.nextPiece != nil {

                                let newPiece = piece.nextPiece!
                                
                                newPiece.view = ShapeView(frame: piece.view.frame, piece: newPiece)

                                delegate?.addPieceView(piece: newPiece)
                                
                                board.pieces.append(newPiece)
                                
                                newPiece.indexes.y = newPiece.indexes.y! + 1
                                
                                if checkForIce(piece: newPiece) == true {
                                    
                                    movePiecesHelper(piece: newPiece, direction: direction)
                                }
                                
                                resetPieceMaker(piece: piece)
                            }
                        }
                    }
                }
            }
            
        case .left:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .left, indexes: piece.indexes)
            
            let notAtWall = piece.indexes.x != 0
            
            if notAtWall {
                
                if spaceIsntBlocked {
                    
                    if piece.shape != .pieceMaker {
                        
                        if piece.isLocked == false {
                            
                            piece.indexes.x = piece.indexes.x! - 1
                            
                            if checkForIce(piece: piece) == true {
                                
                                movePiecesHelper(piece: piece, direction: direction)
                            }
                        }
                        
                    } else {
                        
                        if piece.shape == .pieceMaker && piece.version == 2 {
                            
                            if piece.nextPiece != nil {
                                
                                let newPiece = piece.nextPiece!
                                
                                newPiece.view = ShapeView(frame: piece.view.frame, piece: newPiece)

                                delegate?.addPieceView(piece: newPiece)

                                board.pieces.append(newPiece)
                                
                                newPiece.indexes.x = newPiece.indexes.x! - 1
                                
                                if checkForIce(piece: newPiece) == true {
                                    
                                    movePiecesHelper(piece: newPiece, direction: direction)
                                }
                                
                                resetPieceMaker(piece: piece)
                            }
                        }
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
                    
                    if piece.shape != .pieceMaker {
                        
                        if piece.isLocked == false {
                           
                            piece.indexes.x = piece.indexes.x! + 1
                            
                            if checkForIce(piece: piece) == true {
                                
                                movePiecesHelper(piece: piece, direction: direction)
                            }
                        }
                        
                    } else {
                        
                        if piece.nextPiece != nil {
                            
                            if piece.shape == .pieceMaker && piece.version == 4 {
                                
                                let newPiece = piece.nextPiece!
                                
                                newPiece.view = ShapeView(frame: piece.view.frame, piece: newPiece)

                                delegate?.addPieceView(piece: newPiece)
                                
                                board.pieces.append(newPiece)
                                
                                newPiece.indexes.x = newPiece.indexes.x! + 1
                                
                                if checkForIce(piece: newPiece) == true {
                                    
                                    movePiecesHelper(piece: newPiece, direction: direction)
                                }
                                
                                resetPieceMaker(piece: piece)
                            }
                        }
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
            })
//            .filter({ (piece) -> Bool in
//                piece.isLocked == false
//            })
            {
                movePiecesHelper(piece: piece, direction: direction)
            }
            
            delegate?.movePieces(direction: direction)

        case .down:
            for piece in board.pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.y! > piece2.indexes.y!
                
            })
//            .filter({ (piece) -> Bool in
//                piece.isLocked == false
//            })
            {
                movePiecesHelper(piece: piece, direction: direction)
            }
            
            delegate?.movePieces(direction: direction)

        case .left:
            for piece in board.pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.x! < piece2.indexes.x!
            })
//            .filter({ (piece) -> Bool in
//                piece.isLocked == false
//            })
            {
                movePiecesHelper(piece: piece, direction: direction)
            }
            
            delegate?.movePieces(direction: direction)

        case .right:
            for piece in board.pieces.sorted(by: { (piece1, piece2) -> Bool in
                piece1.indexes.x! > piece2.indexes.x!
            })
//            .filter({ (piece) -> Bool in
//                piece.isLocked == false
//            })
            {
                movePiecesHelper(piece: piece, direction: direction)
            }
            delegate?.movePieces(direction: direction)

        default:
            break
        }
    }
    
    func winner() {
        
        print("you win")
        
    }
    
    var waitAmount = 0.25
        
    func moveBall(ball: Ball, startSide: String) {
        
        switch startSide {
        
        case "unmoved":
            
            let piece = getPieceInfo(index: ball.indexes)
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
            
            if endSide == "center" {
                winner()
            }
            
            return
            
        case "top":
            
            let piece = getPieceInfo(index: ball.indexes)
            let startSide = "top"

            if piece.side.top.color != ball.onColor { return }
            
            if let endSide = piece.side.top.exitSide {
                
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    
                    if piece.shape == .cross {
                        
                        if piece.side.top.closing.isOpen == true {
                            
                            delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                        } else {
                            print("set up func to move ball close to center")
                        }
                    } else {
                        delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                    }
                    
                    if endSide == "center" {
                        winner()
                    }
                }
            } else {
                print("crashed into a wall, or no track in place")
            }
            
            return
            
        case "bottom":
            
            let piece = getPieceInfo(index: ball.indexes)
            let startSide = "bottom"
            
            if piece.side.bottom.color != ball.onColor { return }
            
            if let endSide = piece.side.bottom.exitSide {
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    
                    if piece.shape == .cross {
                        
                        if piece.side.bottom.closing.isOpen == true {
                            
                            delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                        } else {
                            print("set up func to move ball close to center")
                        }
                    } else {
                        
                        delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                    }
                    
                    if endSide == "center" {
                        winner()
                    }
                }
            } else {
                print("crashed into a wall, or no track in place")
            }
            
            return
            
        case "left":
            
            let piece = getPieceInfo(index: ball.indexes)
            let startSide = "left"

            if piece.side.left.color != ball.onColor { return }
            
            if let endSide = piece.side.left.exitSide {
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    
                    if piece.shape == .cross {
                        
                        if piece.side.left.closing.isOpen == true {
                            
                            delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                        } else {
                            print("set up func to move ball close to center")
                        }
                    } else {
                        
                        delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                    }
                    
                    if endSide == "center" {
                        winner()
                    }
                }
            } else {
                print("crashed into a wall, or no track in place")
            }
            
            return
            
        case "right":
            
            let piece = getPieceInfo(index: ball.indexes)
            let startSide = "right"

            if piece.side.right.color != ball.onColor { return }
            
            if let endSide = piece.side.right.exitSide {
                if board.pieces.contains(where: { (piece) -> Bool in
                    piece.indexes == ball.indexes
                }) {
                    
                    if piece.shape == .cross {
                        
                        if piece.side.right.closing.isOpen == true {
                            delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                        }
                    } else {
                        
                        delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                    }
                    if endSide == "center" {
                        winner()
                    }
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
            
            if board.grid[piece.indexes] == center && piece.shape != .entrance {
                
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
        
        if piece.currentSwitch != piece.switches {
            
            piece.currentSwitch += 1
            
        } else {
            
            piece.currentSwitch = 1
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
}
