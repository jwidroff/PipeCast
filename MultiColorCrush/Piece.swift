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
    
    init(){
        
    }
    
    func switch4Tap() {
        
        if currentSwitch != switches{
            currentSwitch += 1
            
        } else {
            currentSwitch = 1

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




