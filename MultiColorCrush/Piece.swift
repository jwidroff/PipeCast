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
    var switches = Int()
    var currentSwitch = Int()
    var side = Side()
    var version = Int()
    var isLocked = false
    var opening = String()
    var nextPiece: Piece?
    var doesPivot = true
    
    init(){
        
    }
    
    init(indexes: Indexes, shape: Shape, colors: [UIColor], version: Int, currentSwitch: Int, isLocked: Bool, opening: String?, doesPivot: Bool?) {
        
        self.indexes = indexes
        self.shape = shape
        self.colors = colors
        self.version = version
        self.currentSwitch = currentSwitch
        self.isLocked = isLocked
        
        if let doesPivot = doesPivot {
            self.doesPivot = doesPivot
        }
        
        if let opening = opening {
            self.opening = opening
        }
        
        if colors.count == 1 {
            
            self.colors.append(colors[0])
        }
        
        
        setPieceSwitches()
        setPieceSides(shape: shape, version: version, currentSwitch: currentSwitch, colors: self.colors, opening: opening)
    }
    
    private func setPieceSwitches() {
        
        //DO NOT DELETE. THIS IS NEEDED FOR THE MANUALLY ADDED PIECES
        if doesPivot == true {
            
            switch shape {
            
            case .elbow:
                switches = 2
                
            case .diagElbow:
                
                switches = 2
                
            case .cross:
                
                switches = 2
                
            case .doubleElbow:
                
                switches = 2
                
            case .stick:
                
                switches = 1
                
            case .colorChanger:
                
                switches = 1
                
            default:
                break
            }
            
        } else {
            
            switches = 1
        }
    }
    
    private func setPieceSides(shape: Shape, version: Int, currentSwitch: Int, colors: [UIColor], opening: String?) {
        
        switch shape {
        
        case .colorChanger:
            
            switch version {
            case 1, 3: //Horizontal
                
                side.left.color = colors[0]
                side.right.color = colors[1]
                side.left.exitSide = "right"
                side.right.exitSide = "left"
                side.left.opening.isOpen = true
                side.right.opening.isOpen = true
                
                
            case 2, 4: //Vertical
                
                side.top.color = colors[0]
                side.bottom.color = colors[1]
                side.top.exitSide = "bottom"
                side.bottom.exitSide = "top"
                side.top.opening.isOpen = true
                side.bottom.opening.isOpen = true
                
            default:
                break
            }
            
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
            
        case .stick:
            
            switch version {
            case 1, 3:
                
                side.right.exitSide = "left"
                side.left.exitSide = "right"
                side.right.color = colors[0]
                side.left.color = colors[0]
                side.left.opening.isOpen = true
                side.right.opening.isOpen = true
                
            case 2, 4:
                
                side.top.exitSide = "bottom"
                side.bottom.exitSide = "top"
                side.top.color = colors[0]
                side.bottom.color = colors[0]
                side.top.opening.isOpen = true
                side.bottom.opening.isOpen = true

            default:
                break
            }
            
            
        case .doubleElbow:
            
            //MARK: Finish this off
            
            switch version {
            case 1:
                
                print()
                
                if currentSwitch == 1 {
                    
                    
                    //TODO: JUST SET THIS UP. NEED TO FINISH FOR ALL VERSIONS AND CURRENTSWITCHS
                    
                    
                    side.top.opening.isOpen = true
                    side.bottom.opening.isOpen = false
                    side.left.opening.isOpen = true
                    side.right.opening.isOpen = false
                    side.right.exitSide = "top"
                    side.left.exitSide = "top"
                    side.top.exitSide = "left"
                    side.bottom.exitSide = nil
                    side.right.color = colors[1]
                    side.top.color = colors[0]
                    side.left.color = colors[0]
//                    piece.side.bottom.color = piece.colors[1]
                    
                } else if currentSwitch == 2 {
                    
                    side.top.opening.isOpen = true
                    side.bottom.opening.isOpen = false
                    side.left.opening.isOpen = false
                    side.right.opening.isOpen = true
                    side.right.exitSide = "top"
                    side.left.exitSide = "top"
                    side.top.exitSide = "right"
                    side.bottom.exitSide = nil
                    side.right.color = colors[1]
                    side.top.color = colors[1]
                    side.left.color = colors[0]
//                    piece.side.bottom.color = piece.colors[1]
                    
                    
                }
                
                
                
            case 2:
                print()

                if currentSwitch == 1 {
                    
                    //left bottom
                    side.top.opening.isOpen = true
                    side.bottom.opening.isOpen = true
                    side.left.opening.isOpen = true
                    side.right.opening.isOpen = false
                    side.right.exitSide = nil
                    side.left.exitSide = "bottom"
                    side.top.exitSide = "left"
                    side.bottom.exitSide = "left"
//                    piece.side.right.color = piece.colors[1]
                    side.top.color = colors[1]
                    side.left.color = colors[0]
                    side.bottom.color = colors[0]
                    
                } else if currentSwitch == 2 {
                    
                    side.top.opening.isOpen = true
                    side.bottom.opening.isOpen = true
                    side.left.opening.isOpen = true
                    side.right.opening.isOpen = false
                    side.right.exitSide = nil
                    side.left.exitSide = "top"
                    side.top.exitSide = "left"
                    side.bottom.exitSide = "left"
//                    piece.side.right.color = piece.colors[1]
                    side.top.color = colors[1]
                    side.left.color = colors[1]
                    side.bottom.color = colors[0]
                    
                }
                
                
            case 3:
                print()

                if currentSwitch == 1 {
                    
                    //Bottom Left on top
                    side.top.opening.isOpen = false
                    side.bottom.opening.isOpen = true
                    side.left.opening.isOpen = true
                    side.right.opening.isOpen = true
                    side.right.exitSide = "bottom"
                    side.left.exitSide = "bottom"
                    side.top.exitSide = nil
                    side.bottom.exitSide = "left"
                    side.right.color = colors[1]
//                    side.top.color = colors[1]
                    side.left.color = colors[0]
                    side.bottom.color = colors[0]
                    
                } else if currentSwitch == 2 {
                    
                    //Bottom right on top
                    side.top.opening.isOpen = false
                    side.bottom.opening.isOpen = true
                    side.left.opening.isOpen = true
                    side.right.opening.isOpen = true
                    side.right.exitSide = "bottom"
                    side.left.exitSide = "bottom"
                    side.top.exitSide = nil
                    side.bottom.exitSide = "right"
                    side.right.color = colors[1]
//                    side.top.color = colors[1]
                    side.left.color = colors[0]
                    side.bottom.color = colors[1]
                    
                }
                
                
                
            case 4:
                
                print()

                if currentSwitch == 1 {
                    
                    side.top.opening.isOpen = true
                    side.bottom.opening.isOpen = true
                    side.left.opening.isOpen = false
                    side.right.opening.isOpen = true
                    side.right.exitSide = "top"
                    side.left.exitSide = nil
                    side.top.exitSide = "right"
                    side.bottom.exitSide = "right"
                    side.right.color = colors[0]
                    side.top.color = colors[0]
                    //                    piece.side.left.color = piece.colors[0]
                    side.bottom.color = colors[1]
                    
                } else if currentSwitch == 2 {
                    
                    side.top.opening.isOpen = true
                    side.bottom.opening.isOpen = true
                    side.left.opening.isOpen = false
                    side.right.opening.isOpen = true
                    side.right.exitSide = "bottom"
                    side.left.exitSide = nil
                    side.top.exitSide = "right"
                    side.bottom.exitSide = "right"
                    side.right.color = colors[1]
                    side.top.color = colors[0]
//                    piece.side.left.color = piece.colors[0]
                    side.bottom.color = colors[1]
                    
                    
                }
                
                
                
            default:
                break
            }
            
            
            
            
        case .diagElbow:
            
            side.top.opening.isOpen = true
            side.bottom.opening.isOpen = true
            side.left.opening.isOpen = true
            side.right.opening.isOpen = true
            
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
    var exited = Bool()
    var piecesPassed = [Piece]()
}

enum Direction {
    
    case up
    case down
    case left
    case right
    case none
}


