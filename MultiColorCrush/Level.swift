//
//  Level.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 8/18/20.
//  Copyright © 2020 Jeffery Widroff. All rights reserved.
//

import Foundation
import UIKit


class Level {
    
    var number = Int()
    var boardHeight = Int()
    var boardWidth = Int()
    var numberOfPieces = Int()
    var board = Board()
    var iceLocations = [Indexes]()
    var pieceMakerLocations = [Indexes]()
    var walls = [Indexes]()
    var balls = [Ball]()
    
    var pieces = [Piece]()
    
    init(){
        
    }
    
    
}


class LevelModel {
    
    let level = Level()
    
    private var pieces = [Piece]()
    
    //MARK: Make this spit out a board, not a level!
    func returnLevel(levelNumber: Int) -> Level {
        
        
        switch levelNumber {
            
        case 1:
            
            setupGrid() //TODO: Add Perimeters

            
            let entrance = Piece(indexes: Indexes(x: 0, y: 0), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: "bottom")
            level.pieces.append(entrance)

            let exit = Piece(indexes: Indexes(x: 0, y: 2), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: "top")
            level.pieces.append(exit)
            
            let piece = Piece(indexes: Indexes(x: 1, y: 1), shape: .diagElbow, colors: [UIColor.green, UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil)
            level.pieces.append(piece)
            
            
            let wall = Piece(indexes: Indexes(x: 3, y: 4), shape: .wall, colors: [.darkGray], version: 1, currentSwitch: 1, isLocked: true, opening: nil)
            
            level.pieces.append(wall)

            let pieceMaker = Piece(indexes: Indexes(x: 3, y: 5), shape: .pieceMaker, colors: [.darkGray], version: 1, currentSwitch: 1, isLocked: true, opening: "top")


            level.pieces.append(pieceMaker)

            
            setUpLevelDefaults()
            
            
            
            
            
        case 2:
            
            level.number = 2
            level.iceLocations = [Indexes(x: 1, y: 2), Indexes(x: 2, y: 1)]
            level.pieceMakerLocations = [Indexes(x: 3, y: 3)]
            level.boardHeight = 10
            level.boardWidth = 5
            level.numberOfPieces = 3
            
            
            setupPieceMakers()
            
            
            
        default:
            break
            
        }
        return level

    }
    
    private func setUpLevelDefaults() {
//        setupEntrances()
//        setupExits()
//        setupPieceMakers()
//        setupWalls()
        setupBalls()
        setupPieces()
    }
    
    private func setupGrid() {
        
        if level.boardHeight == Int() {
            level.boardHeight = 10
        }
        
        if level.boardWidth == Int() {
            level.boardWidth = 5
        }
        if level.iceLocations == [Indexes()] {
            level.iceLocations = [Indexes()]
        }
        //[Indexes(x: 2, y: 2), Indexes(x: 2, y: 1)]
    }
    
    private func setupPieceMakers() {

        //Continue here
        
        
//        for _ in 1...1 {
//
//            let pieceMaker = Piece()
//            setPieceIndex(piece: pieceMaker)
//            pieceMaker.isLocked = true
//            pieceMaker.colors = [.black]
//            pieceMaker.shape = .pieceMaker
//            let version = Int(arc4random_uniform(UInt32(4))) + 1
//            pieceMaker.version = version
//
//            let nextPiece = Piece()
//            nextPiece.indexes = pieceMaker.indexes
//            setPieceShape(piece: nextPiece)
//            setPieceColor(piece: nextPiece)
//            setPieceSwitches(piece: nextPiece)
//            setPieceSides(piece: nextPiece)
//            pieceMaker.nextPiece = nextPiece
//            level.pieces.append(pieceMaker)
//
//
//
//
//        }
    }
    
    private func setPieceIndex(piece: Piece) {

        let index = Indexes(x: Int(arc4random_uniform(UInt32(level.boardWidth))), y: Int(arc4random_uniform(UInt32(level.boardHeight))))

        // This is to make sure that the pieces dont start on 1) another piece 2) an entrance 3) an exit 4) a wall
        if level.pieces.contains(where: { (pieceX) -> Bool in
            pieceX.indexes == index
        }){
            setPieceIndex(piece: piece)
        } else {
            piece.indexes = index
        }
    }
    
    private func setPieceShape(piece: Piece) {
        
        let version = Int(arc4random_uniform(UInt32(4))) + 1
        piece.version = version
        let randomShapes:[Shape] = [.cross, .diagElbow]//, .elbow, .stick]// .doubleElbow, .quadBox, .diagElbow]//, "sword"]
        piece.shape = randomShapes[Int(arc4random_uniform(UInt32(randomShapes.count)))]
    }
    
    
    private func setPieceColor(piece: Piece) {
        
        let randomColors:[UIColor] = [UIColor.red]//, UIColor.blue]//, UIColor.green, UIColor.purple, UIColor.yellow, UIColor.orange]//, UIColor.white, UIColor.cyan]
        let randomColor1 = randomColors[Int(arc4random_uniform(UInt32(randomColors.count)))]
        let randomColor2 = randomColors[Int(arc4random_uniform(UInt32(randomColors.count)))]
        
        piece.colors = [randomColor1, randomColor2]
    }
    
    private func setPieceSwitches(piece: Piece) {
        
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
    
    private func setPieceSides(piece: Piece) {
      
        switch piece.shape {
            
        case .elbow:
            
            switch piece.version {

            case 1:
                
                //Top Pivot
                
                if piece.currentSwitch == 1 {
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
//                    piece.side.top.closing.isOpen = true
//                    piece.side.left.closing.isOpen = true
                    
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
//                    piece.side.top.closing.isOpen = true
//                    piece.side.right.closing.isOpen = true
                    
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
//                    piece.side.bottom.closing.isOpen = true
//                    piece.side.left.closing.isOpen = true
                    
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
//                    piece.side.top.closing.isOpen = true
//                    piece.side.left.closing.isOpen = true
                    
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
//                    piece.side.bottom.closing.isOpen = true
//                    piece.side.right.closing.isOpen = true
                    
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
//                    piece.side.bottom.closing.isOpen = true
//                    piece.side.left.closing.isOpen = true
                    
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
//                    piece.side.top.closing.isOpen = true
//                    piece.side.right.closing.isOpen = true
                    
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
//                    piece.side.bottom.closing.isOpen = true
//                    piece.side.right.closing.isOpen = true
                    
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
                    
//                    piece.side.left.closing.isOpen = true
//                    piece.side.right.closing.isOpen = true
                    piece.side.right.exitSide = "left"
                    piece.side.left.exitSide = "right"
                    piece.side.right.color = piece.colors[1]
                    piece.side.left.color = piece.colors[1]
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    
                } else if piece.currentSwitch == 2 {
                    
//                    piece.side.top.closing.isOpen = true
//                    piece.side.bottom.closing.isOpen = true
                    piece.side.top.exitSide = "bottom"
                    piece.side.bottom.exitSide = "top"
                    piece.side.top.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                }
                
            case 2, 4:
                
                if piece.currentSwitch == 1 {
                    
                   
//                    piece.side.top.closing.isOpen = true
//                    piece.side.bottom.closing.isOpen = true
                    piece.side.top.exitSide = "bottom"
                    piece.side.bottom.exitSide = "top"
                    piece.side.top.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    
                } else if piece.currentSwitch == 2 {
                    
//                    piece.side.left.closing.isOpen = true
//                    piece.side.right.closing.isOpen = true
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
//            piece.side.top.closing.isOpen = true
//            piece.side.bottom.closing.isOpen = true
//            piece.side.left.closing.isOpen = true
//            piece.side.right.closing.isOpen = true
            
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
    
    private func setupEntrances() {
        
        for _ in 1...1 {
            
            let entrance = Piece()
            setPieceIndex(piece: entrance)
//            entrance.indexes = Indexes(x: 3, y: 4)
            entrance.isLocked = true
            entrance.colors = [.red]
            
            //TODO - Make this different per side
            entrance.opening = "right"
            entrance.side.right.color = entrance.colors[0]
            entrance.shape = .entrance
            level.pieces.append(entrance)
        }
    }
    
    private func setupExits() {
        
        for _ in 1...1 {
            
            let exit = Piece()
            setPieceIndex(piece: exit)
//            exit.indexes = Indexes(x: 3, y: 3)

            exit.isLocked = true
            exit.colors = [.red]
            exit.opening = "left"
            exit.side.left.color = exit.colors[0]
            exit.side.left.opening.isOpen = true
            exit.side.left.exitSide = "center" //TODO: Change
            exit.shape = .exit
            level.pieces.append(exit)
        }
    }
    
    private func setupWalls() {
        
        for _ in 0...0 {

            let wall = Piece()
            setPieceIndex(piece: wall)
            wall.isLocked = true
            wall.colors = [.lightGray]
            wall.shape = .wall
            level.pieces.append(wall)
        }
    }
    
    private func setupBalls() {
        
        for piece in level.pieces {
            
            if piece.shape == .entrance {

            
            let ball = Ball()
                ball.indexes = piece.indexes
                ball.onColor = piece.colors[0]
                level.balls.append(ball)
            }
        }
//        board.balls = board.balls
    }
    private func setupPieces() {
        
        if level.numberOfPieces == Int() {
            
            for _ in 0...1 {
                
                let piece = Piece()
                setPieceIndex(piece: piece)
                setPieceShape(piece: piece)
                setPieceColor(piece: piece)
                setPieceSwitches(piece: piece)
                setPieceSides(piece: piece)
                level.pieces.append(piece)
                
            }
            
        } else {
                
            for _ in 0..<level.numberOfPieces {
                
                let piece = Piece()
                setPieceIndex(piece: piece)
                setPieceShape(piece: piece)
                setPieceColor(piece: piece)
                setPieceSwitches(piece: piece)
                setPieceSides(piece: piece)
                level.pieces.append(piece)
                
            }
            
        }
        
        
    }
    
}


