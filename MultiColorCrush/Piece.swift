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
    
    init(indexes: Indexes, shape: Shape, colors: [UIColor], version: Int, currentSwitch: Int, isLocked: Bool, opening: String?) {
        
        self.indexes = indexes
        self.shape = shape
        self.colors = colors
        self.version = version
        self.currentSwitch = currentSwitch
        self.isLocked = isLocked
        if let opening = opening {
            self.opening = opening
        }
        setPieceSwitches()
        setPieceSides(shape: shape, version: version, currentSwitch: currentSwitch, colors: colors, opening: opening)
        
    }
    
    private func setPieceSwitches() {
        
        switch shape {
        
        case .elbow:
            switches = 2
            
        case .diagElbow:
            
            switches = 2
            
        case .cross:
            
            switches = 2
            
            
        case .stick:
            
            switches = 1
            
            
        default:
            break
        }
    }
    
    private func setPieceSides(shape: Shape, version: Int, currentSwitch: Int, colors: [UIColor], opening: String?) {
        
        switch shape {
        
        case .entrance:
            
            switch opening {
            
            
            case "top":
                
                side.top.color = colors[0]

                
            case "bottom":
                
                side.bottom.color = colors[0]

                
            case "left":
                
                side.left.color = colors[0]

                
            case "right":
                
                side.right.color = colors[0]

                
            default:
                break
            }
        
        case .exit:
            
            
            switch opening {
            
            
            case "top":
                
                side.top.color = colors[0]
                side.top.exitSide = "center"
                side.top.opening.isOpen = true
                
            case "bottom":
                
                side.bottom.color = colors[0]
                side.bottom.exitSide = "center"
                side.bottom.opening.isOpen = true
                
            case "left":
                
                side.left.color = colors[0]
                side.left.exitSide = "center"
                side.left.opening.isOpen = true
                
            case "right":
                
                side.right.color = colors[0]
                side.right.exitSide = "center"
                side.right.opening.isOpen = true
                
            default:
                break
            }
            
        case .elbow:
            
            switch version {

            case 1:
                
                //Top Pivot
                
                if currentSwitch == 1 {
                    
                    side.top.opening.isOpen = true
                    side.left.opening.isOpen = true
//                    piece.side.top.closing.isOpen = true
//                    piece.side.left.closing.isOpen = true
                    
                    side.top.color = colors[0]
                    side.left.color = colors[0]
                    side.bottom.color = nil
                    side.right.color = nil
                    
                    side.top.exitSide = "left"
                    side.left.exitSide = "top"
                    side.right.exitSide = nil
                    side.bottom.exitSide = nil
                    
                } else if currentSwitch == 2 {
                    
                    side.top.opening.isOpen = true
                    side.right.opening.isOpen = true
//                    piece.side.top.closing.isOpen = true
//                    piece.side.right.closing.isOpen = true
                    
                    side.top.color = colors[0]
                    side.right.color = colors[0]
                    side.bottom.color = nil
                    side.left.color = nil
                    
                    side.top.exitSide = "right"
                    side.right.exitSide = "top"
                    side.bottom.exitSide = nil
                    side.left.exitSide = nil
                }
                
            case 2:
                
                //Left Pivot
                
                if currentSwitch == 1 {
                    
                    side.bottom.opening.isOpen = true
                    side.left.opening.isOpen = true
//                    piece.side.bottom.closing.isOpen = true
//                    piece.side.left.closing.isOpen = true
                    
                    side.bottom.exitSide = "left"
                    side.left.exitSide = "bottom"
                    side.right.exitSide = nil
                    side.top.exitSide = nil
                    
                    side.bottom.color = colors[0]
                    side.left.color = colors[0]
                    side.top.color = nil
                    side.right.color = nil
                    
                } else if currentSwitch == 2 {
                    
                    side.top.opening.isOpen = true
                    side.left.opening.isOpen = true
//                    piece.side.top.closing.isOpen = true
//                    piece.side.left.closing.isOpen = true
                    
                    side.top.exitSide = "left"
                    side.left.exitSide = "top"
                    side.right.exitSide = nil
                    side.bottom.exitSide = nil

                    side.top.color = colors[0]
                    side.left.color = colors[0]
                    side.bottom.color = nil
                    side.right.color = nil
                    
                }
                
            case 3:
                
                //Bottom Pivot
                
                if currentSwitch == 1 {
                    
                    side.bottom.opening.isOpen = true
                    side.right.opening.isOpen = true
//                    piece.side.bottom.closing.isOpen = true
//                    piece.side.right.closing.isOpen = true
                    
                    side.bottom.exitSide = "right"
                    side.right.exitSide = "bottom"
                    side.top.exitSide = nil
                    side.left.exitSide = nil

                    side.bottom.color = colors[0]
                    side.right.color = colors[0]
                    side.top.color = nil
                    side.left.color = nil

                } else if currentSwitch == 2 {
                    
                    side.bottom.opening.isOpen = true
                    side.left.opening.isOpen = true
//                    piece.side.bottom.closing.isOpen = true
//                    piece.side.left.closing.isOpen = true
                    
                    side.bottom.exitSide = "left"
                    side.left.exitSide = "bottom"
                    side.right.exitSide = nil
                    side.top.exitSide = nil
                    
                    side.bottom.color = colors[0]
                    side.left.color = colors[0]
                    side.top.color = nil
                    side.right.color = nil
                }
                
            case 4:
                
                //Right Pivot
                
                if currentSwitch == 1 {
                    
                    side.top.opening.isOpen = true
                    side.right.opening.isOpen = true
//                    piece.side.top.closing.isOpen = true
//                    piece.side.right.closing.isOpen = true
                    
                    side.top.exitSide = "right"
                    side.right.exitSide = "top"
                    side.bottom.exitSide = nil
                    side.left.exitSide = nil
                    
                    side.top.color = colors[0]
                    side.right.color = colors[0]
                    side.bottom.color = nil
                    side.left.color = nil

                } else if currentSwitch == 2 {
                    
                    side.bottom.opening.isOpen = true
                    side.right.opening.isOpen = true
//                    piece.side.bottom.closing.isOpen = true
//                    piece.side.right.closing.isOpen = true
                    
                    side.bottom.exitSide = "right"
                    side.right.exitSide = "bottom"
                    side.top.exitSide = nil
                    side.left.exitSide = nil
                    
                    side.bottom.color = colors[0]
                    side.right.color = colors[0]
                    side.top.color = nil
                    side.left.color = nil
                }
                
            default:
                break
            }
            
        case .cross:
            
            
            side.right.exitSide = "left"
            side.left.exitSide = "right"
            side.top.exitSide = "bottom"
            side.bottom.exitSide = "top"
            
            side.right.color = colors[1]
            side.left.color = colors[1]
            side.top.color = colors[0]
            side.bottom.color = colors[0]
            
            side.top.opening.isOpen = true
            side.bottom.opening.isOpen = true
            side.left.opening.isOpen = true
            side.right.opening.isOpen = true
            
            switch version {
            
            case 1, 3:
                
                if currentSwitch == 1 {
                    
                    //Horizontal Pipe on top

                    side.left.closing.isOpen = true
                    side.right.closing.isOpen = true
                    side.top.closing.isOpen = false
                    side.bottom.closing.isOpen = false
                    
                } else if currentSwitch == 2 {
                    
                    //Vertical Pipe on top

                    side.left.closing.isOpen = false
                    side.right.closing.isOpen = false
                    side.top.closing.isOpen = true
                    side.bottom.closing.isOpen = true
                }

            case 2, 4:
                
                if  currentSwitch == 1 {
                    
                    //Horizontal Pipe on top

                    side.left.closing.isOpen = true
                    side.right.closing.isOpen = true
                    side.top.closing.isOpen = false
                    side.bottom.closing.isOpen = false
                    
                } else if currentSwitch == 2 {
                    
                    //Vertical Pipe on top
                    
                    side.left.closing.isOpen = false
                    side.right.closing.isOpen = false
                    side.top.closing.isOpen = true
                    side.bottom.closing.isOpen = true
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
            
            switch version {
            case 1, 3:
                
                if currentSwitch == 1 {
                    
//                    piece.side.left.closing.isOpen = true
//                    piece.side.right.closing.isOpen = true
                    side.right.exitSide = "left"
                    side.left.exitSide = "right"
                    side.right.color = colors[1]
                    side.left.color = colors[1]
                    side.left.opening.isOpen = true
                    side.right.opening.isOpen = true
                    
                } else if currentSwitch == 2 {
                    
//                    piece.side.top.closing.isOpen = true
//                    piece.side.bottom.closing.isOpen = true
                    side.top.exitSide = "bottom"
                    side.bottom.exitSide = "top"
                    side.top.color = colors[0]
                    side.bottom.color = colors[0]
                    side.top.opening.isOpen = true
                    side.bottom.opening.isOpen = true
                }
                
            case 2, 4:
                
                if currentSwitch == 1 {
                    
                   
//                    piece.side.top.closing.isOpen = true
//                    piece.side.bottom.closing.isOpen = true
                    side.top.exitSide = "bottom"
                    side.bottom.exitSide = "top"
                    side.top.color = colors[0]
                    side.bottom.color = colors[0]
                    side.top.opening.isOpen = true
                    side.bottom.opening.isOpen = true
                    
                } else if currentSwitch == 2 {
                    
//                    piece.side.left.closing.isOpen = true
//                    piece.side.right.closing.isOpen = true
                    side.right.exitSide = "left"
                    side.left.exitSide = "right"
                    side.right.color = colors[1]
                    side.left.color = colors[1]
                    side.left.opening.isOpen = true
                    side.right.opening.isOpen = true
                }
                
            default:
                break
            }
            
        case .diagElbow:
            
            side.top.opening.isOpen = true
            side.bottom.opening.isOpen = true
            side.left.opening.isOpen = true
            side.right.opening.isOpen = true
//            piece.side.top.closing.isOpen = true
//            piece.side.bottom.closing.isOpen = true
//            piece.side.left.closing.isOpen = true
//            piece.side.right.closing.isOpen = true
            
            switch version {
            
            case 1, 3:
                
                //Pivots on left and right

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

                    side.right.exitSide = "bottom"
                    side.left.exitSide = "top"
                    side.top.exitSide = "left"
                    side.bottom.exitSide = "right"
                    
                    side.right.color = colors[0]
                    side.top.color = colors[1]
                    side.left.color = colors[1]
                    side.bottom.color = colors[0]
                     
                }
                
            case 2, 4:
                
                //Pivots on top and bottom
                
                if currentSwitch == 1 {
                    
                    side.left.exitSide = "top"
                    side.right.exitSide = "bottom"
                    side.bottom.exitSide = "right"
                    side.top.exitSide = "left"
                    
                    side.right.color = colors[1]
                    side.top.color = colors[0]
                    side.left.color = colors[0]
                    side.bottom.color = colors[1]
                
                } else if currentSwitch == 2 {

                    side.left.exitSide = "bottom"
                    side.right.exitSide = "top"
                    side.bottom.exitSide = "left"
                    side.top.exitSide = "right"
                    
                    side.right.color = colors[0]
                    side.top.color = colors[0]
                    side.left.color = colors[1]
                    side.bottom.color = colors[1]
                }
                    
            default:
                break
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



