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
    var shape = String()
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
            print("current switch \(currentSwitch)")
        } else {
            currentSwitch = 1
            print("current switch \(currentSwitch)")
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
    
    var isOpen = false
    var isPivot = false
    
    
}

class Bottom {
    
    var isOpen = false
    var isPivot = false

    
}

class Left {
    
    var isOpen = false
    var isPivot = false

    
}

class Right {
    
    var isOpen = false
    var isPivot = false

    
}



class Ball {
    
    var view = ShapeView()
    var indexes = Indexes()
    
    
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




