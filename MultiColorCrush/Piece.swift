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
    var center = CGPoint()
    var color = UIColor()
    var opacity = Int()
//    var powers = [String]()
//    var power = String()
    var switches = Int()
    var currentSwitch = Int()
    var side = Side()
    var version = Int()
    
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
            
            
            if currentSwitch == 1 {
                
                side.top.exitSide = "left"
                side.left.exitSide = "top"
                side.right.exitSide = nil
                
            } else if currentSwitch == 2 {

                side.top.exitSide = "right"
                side.right.exitSide = "top"
                side.left.exitSide = nil
            }
            
            side.left.opening.isOpen = !side.left.opening.isOpen
            side.right.opening.isOpen = !side.right.opening.isOpen
            side.left.closing.isOpen = !side.left.closing.isOpen
            side.right.closing.isOpen = !side.right.closing.isOpen
            
        case .doubleElbow:
            
            if currentSwitch == 1 {
                
                side.top.exitSide = "right"
                side.right.exitSide = "top"
                side.left.exitSide = nil
                
            } else if currentSwitch == 2 {

                side.top.exitSide = "left"
                side.left.exitSide = "top"
                side.right.exitSide = nil

            }
            
            
            side.left.closing.isOpen = !side.left.closing.isOpen
            side.right.closing.isOpen = !side.right.closing.isOpen
            
            
            
            
        case .quadBox: // Nothing to set as far as openings and closings

            
            if currentSwitch == 1 {
                
                side.top.exitSide = "left"
                side.left.exitSide = "top"
                side.bottom.exitSide = "right"
                side.right.exitSide = "bottom"
                
            } else if currentSwitch == 2 {

                side.top.exitSide = "right"
                side.right.exitSide = "top"
                side.bottom.exitSide = "left"
                side.left.exitSide = "bottom"

            }
            
            
            
        case .cross:

           if currentSwitch == 1 {
        
            side.right.exitSide = "left"
            side.left.exitSide = "right"
            
           } else if currentSwitch == 2 {

            side.top.exitSide = "bottom"
            side.bottom.exitSide = "top"

           }
            
            side.left.closing.isOpen = !side.left.closing.isOpen
            side.right.closing.isOpen = !side.right.closing.isOpen
            side.top.closing.isOpen = !side.top.closing.isOpen
            side.bottom.closing.isOpen = !side.bottom.closing.isOpen
            
            
            
        case .sword:
            print("TODO - Set this")

            
        case .diagElbow: // Nothing to set as far as openings and closings
                    
            
            
            if currentSwitch == 1 {
            
                side.right.exitSide = "top"
                side.left.exitSide = "bottom"
                side.top.exitSide = "right"
                side.bottom.exitSide = "left"
                
            } else if currentSwitch == 2 {
                
                side.top.exitSide = "left"
                side.left.exitSide = "top"
                side.bottom.exitSide = "right"
                side.right.exitSide = "bottom"
                
            }
            
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
    
}

class Bottom {
    
    var opening = Opening()
    var closing  = Closing()
    var exitSide: String?

}

class Left {

    var opening = Opening()
    var closing  = Closing()
    var exitSide: String?

}

class Right {

    var opening = Opening()
    var closing  = Closing()
    var exitSide: String?

}

class Opening {
    
    var isOpen = false

}

class Closing {
    
    var isOpen = false
    
}



class Ball {
    
    var view = ShapeView()
    var indexes = Indexes()
    var direction = Direction.none
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




