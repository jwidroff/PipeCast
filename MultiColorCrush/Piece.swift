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
    var nextPiece: Piece?
//    var next = Piece()
    
//    var nextPieceX: Piece?
    
    
    
    init(){
        
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
    var onColor = UIColor()
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
    var view = ShapeView()
}



