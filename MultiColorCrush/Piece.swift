//
//  Piece.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 8/17/20.
//  Copyright © 2020 Jeffery Widroff. All rights reserved.
//

import Foundation
import UIKit


class Piece {
    
    var indexes = Indexes()
    var shape: Shape = .regular
    var view = ShapeView()
    var colors = [UIColor()]
//    var opacity = Int()
    var switches = Int()
    var currentSwitch = Int()
    var side = Side()
    var version = Int()
    var isLocked = false
    var opening = String()
    var nextPiece = NextPiece()
    
    
    
    init(){
        
    }
    
    func switch4Tap() {
        
        if currentSwitch != switches{
            
            currentSwitch += 1
        } else {
            
            currentSwitch = 1
        }
        
        switch shape {
            
        case .elbow:
            
            switch version {
            
            case 1:
                
                if currentSwitch == 1 {
                    
                    side.top.exitSide = "left"
                    side.left.exitSide = "top"
                    side.right.exitSide = nil
                    side.bottom.exitSide = nil
                    
                    side.top.color = colors[0]
                    side.left.color = colors[0]
                    side.right.color = nil
                    side.bottom.color = nil
                    
                } else if currentSwitch == 2 {

                    side.top.exitSide = "right"
                    side.right.exitSide = "top"
                    side.left.exitSide = nil
                    side.bottom.exitSide = nil
                    
                    side.top.color = colors[0]
                    side.right.color = colors[0]
                    side.left.color = nil
                    side.bottom.color = nil
                }
                
                side.left.opening.isOpen = !side.left.opening.isOpen
                side.right.opening.isOpen = !side.right.opening.isOpen
                side.left.closing.isOpen = !side.left.closing.isOpen
                side.right.closing.isOpen = !side.right.closing.isOpen

            case 2:
                
                if currentSwitch == 1 {
                    
                    side.left.exitSide = "bottom"
                    side.bottom.exitSide = "left"
                    side.top.exitSide = nil
                    side.right.exitSide = nil
                    
                    side.bottom.color = colors[0]
                    side.left.color = colors[0]
                    side.right.color = nil
                    side.top.color = nil
                    
                } else if currentSwitch == 2 {

                    side.left.exitSide = "top"
                    side.top.exitSide = "left"
                    side.bottom.exitSide = nil
                    side.right.exitSide = nil
                    
                    side.top.color = colors[0]
                    side.left.color = colors[0]
                    side.right.color = nil
                    side.bottom.color = nil
                }
                
                side.top.opening.isOpen = !side.top.opening.isOpen
                side.bottom.opening.isOpen = !side.bottom.opening.isOpen
                side.top.closing.isOpen = !side.top.closing.isOpen
                side.bottom.closing.isOpen = !side.bottom.closing.isOpen
                
            case 3:
                
                if currentSwitch == 1 {
                    
                    side.bottom.exitSide = "right"
                    side.right.exitSide = "bottom"
                    side.left.exitSide = nil
                    side.top.exitSide = nil
                    
                    side.right.color = colors[0]
                    side.bottom.color = colors[0]
                    side.left.color = nil
                    side.top.color = nil
                    
                } else if currentSwitch == 2 {

                    side.bottom.exitSide = "left"
                    side.left.exitSide = "bottom"
                    side.right.exitSide = nil
                    side.top.exitSide = nil

                    side.bottom.color = colors[0]
                    side.left.color = colors[0]
                    side.right.color = nil
                    side.top.color = nil
                }
                
                side.left.opening.isOpen = !side.left.opening.isOpen
                side.right.opening.isOpen = !side.right.opening.isOpen
                side.left.closing.isOpen = !side.left.closing.isOpen
                side.right.closing.isOpen = !side.right.closing.isOpen
                
            case 4:
                
                if currentSwitch == 1 {
                    
                    side.right.exitSide = "top"
                    side.top.exitSide = "right"
                    side.bottom.exitSide = nil
                    side.left.exitSide = nil

                    side.top.color = colors[0]
                    side.right.color = colors[0]
                    side.left.color = nil
                    side.bottom.color = nil
                    
                } else if currentSwitch == 2 {

                    side.right.exitSide = "bottom"
                    side.bottom.exitSide = "right"
                    side.top.exitSide = nil
                    side.left.exitSide = nil

                    side.bottom.color = colors[0]
                    side.right.color = colors[0]
                    side.top.color = nil
                    side.left.color = nil
                }
                
                side.top.opening.isOpen = !side.top.opening.isOpen
                side.bottom.opening.isOpen = !side.bottom.opening.isOpen
                side.top.closing.isOpen = !side.top.closing.isOpen
                side.bottom.closing.isOpen = !side.bottom.closing.isOpen
                
            default:
                break
            }
            
//            print("piece left side exitSide \(side.left.exitSide)")
//            print("piece right side exitSide \(side.right.exitSide)")
//            print("piece top side exitSide \(side.top.exitSide)")
//            print("piece bottom side exitSide \(side.bottom.exitSide)")
//            
//            

            
        case .diagElbow: // Nothing to set as far as openings and closings
                    
            switch version {
            
            case 1, 3:
                
                if currentSwitch == 1 {
                
                    side.right.exitSide = "top"
                    side.left.exitSide = "bottom"
                    side.top.exitSide = "right"
                    side.bottom.exitSide = "left"
                    
                    side.right.color = colors[0]
                    side.top.color = colors[0]
                    side.left.color = colors[1]
                    side.bottom.color = colors[1]
                    
                    
                } else if currentSwitch == 2 {
                    
                    side.top.exitSide = "left"
                    side.left.exitSide = "top"
                    side.bottom.exitSide = "right"
                    side.right.exitSide = "bottom"
                    
                    
                    side.right.color = colors[0]
                    side.top.color = colors[1]
                    side.left.color = colors[1]
                    side.bottom.color = colors[0]
                    
                }
                
            case 2, 4:
                
                if currentSwitch == 1 {
                
                    side.top.exitSide = "left"
                    side.left.exitSide = "top"
                    side.bottom.exitSide = "right"
                    side.right.exitSide = "bottom"
                    
                    side.right.color = colors[1]
                    side.top.color = colors[0]
                    side.left.color = colors[0]
                    side.bottom.color = colors[1]
                    
                    
                } else if currentSwitch == 2 {
                    
                    
                    side.right.exitSide = "top"
                    side.left.exitSide = "bottom"
                    side.top.exitSide = "right"
                    side.bottom.exitSide = "left"
                    
                    
                    side.right.color = colors[0]
                    side.top.color = colors[0]
                    side.left.color = colors[1]
                    side.bottom.color = colors[1]
                }
            
            default:
                break
            }
            
            
//            print("version \(version)")
//
//            print("currentSwitch \(currentSwitch)")
//
//
//            print("piece left side color \(side.left.color)")
//            print("piece right side color \(side.right.color)")
//            print("piece top side color \(side.top.color)")
//            print("piece bottom side color \(side.bottom.color)")
            
            
        default:
            break
        }
    }
}

class Side {
    
    var top = Top()
    var bottom = Bottom()
    var left = Left()
    var right = Right()
}

class Top {
    
    var opening = Opening()
    var closing  = Closing()
    var exitSide: String?
    var color: UIColor?
}

class Bottom {
    
    var opening = Opening()
    var closing  = Closing()
    var exitSide: String?
    var color: UIColor?
}

class Left {

    var opening = Opening()
    var closing  = Closing()
    var exitSide: String?
    var color: UIColor?
}

class Right {

    var opening = Opening()
    var closing  = Closing()
    var exitSide: String?
    var color: UIColor?
}

class Opening {
    
    var isOpen = false
}

class Closing {
    
    var isOpen = false
}

class Ball {
    
    var view = BallView()
    var indexes = Indexes()
    var startSide = "unmoved"
}

enum Direction {
    
    case up
    case down
    case left
    case right
    case none
}

enum PieceShape: String {
    
    case square = "square"
    case triangle = "triangle"
    case hexigon = "hexigon"
    case circle = "circle"
    case star = "star"
    case cross = "cross"
    case xShape = "xShape"
}

class NextPiece {
    
    var shape = Shape.regular
    var colors = [UIColor]()
    var version = Int()
    var currentSwitch = Int()
    
}



