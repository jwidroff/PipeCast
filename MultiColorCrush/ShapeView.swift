
//
//  Shape.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 8/25/20.
//  Copyright © 2020 Jeffery Widroff. All rights reserved.
//

import Foundation
import UIKit



class ShapeView : UIView {
    
    var name:Shape = .regular
    
    var version = Int()
    
    var color: CGColor?
        
    var switches = Int()
    
    var currentSwitch = Int()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, color: CGColor, shape: Shape, version: Int?) {

        self.color  = color
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.name = shape
        
        switch shape {
        case .elbow:
            switches = 2
            currentSwitch = 1
            self.version = version!
            
        case .doubleElbow:
            switches = 2
            currentSwitch = 1

        case .sword:
            switches = 3
            currentSwitch = 1
            
        case .cross:
            switches = 2
            currentSwitch = 1

        case .quadBox:
            switches = 2
            currentSwitch = 1
            
        case .diagElbow:
            switches = 2
            currentSwitch = 1
            self.version = version!

        default:
            break
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        switch name {
            
        case .regular:
            
            guard let context = UIGraphicsGetCurrentContext() else { return }
            let w = frame.width / 10 * 9
            let h = frame.height / 10 * 9
            let x = (frame.width - w) / 2
            let y = (frame.height - h) / 2
            let rect1 = CGRect(x: x, y: y, width: w, height: h)
            context.setFillColor(self.color!)
            context.addRects([rect1])
            context.fill(rect1)
            
        case .elbow:

            guard let context = UIGraphicsGetCurrentContext() else { return }
            let diff = frame.height / 10
            let posHeight = frame.height + diff
            let posWidth = frame.width + diff
            let negHeight = frame.height - diff
            let negWidth = frame.width - diff

                switch version {
                
                case 1:
                    
                    if currentSwitch == 1 {
                    
                        // TOP PIVOT TO LEFT SIDE
                    let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: posWidth, height: posHeight)
                    context.addEllipse(in: rect1)
                    context.setFillColor(color!)
                    context.fillEllipse(in: rect1)
                    
                    let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: negWidth, height: negHeight)
                    context.addEllipse(in: rect2)
                    context.setFillColor(UIColor.black.cgColor)
                    context.fillEllipse(in: rect2)
                    
                    currentSwitch = 2
                    
                    } else {
                        
                        // TOP PIVOT TO RIGHT SIDE
                        let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: posWidth, height: posHeight)
                        context.addEllipse(in: rect3)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect3)

                        let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: negWidth, height: negHeight)
                        context.addEllipse(in: rect4)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect4)
                        
                        currentSwitch = 1
                    }
                    
                    //TOP PIVOT
                    let width = bounds.width / 2
                    let x = (bounds.midX - (width / 2))
                    let pivotRect = CGRect(x: x, y: bounds.minY, width: width, height: 5)
                    context.setFillColor(color!)
                    context.addRects([pivotRect])
                    context.fill(pivotRect)
                    
                case 2:
                    
                    if currentSwitch == 1 {
                        
                        //LEFT PIVOT TO BOTTOM
                        let rect5 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) - diff, width: posWidth, height: posHeight)
                        context.addEllipse(in: rect5)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect5)
                        
                        let rect6 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) + diff , width: negWidth, height: negHeight)
                        context.addEllipse(in: rect6)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect6)
                        
                        currentSwitch = 2
                    } else {
                        
                        //LEFT PIVOT TO TOP
                        let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: posWidth, height: posHeight)
                        context.addEllipse(in: rect1)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect1)
                        
                        let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: negWidth, height: negHeight)
                        context.addEllipse(in: rect2)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect2)
                        
                        currentSwitch = 1
                    }
                    
                    //Left Pivot
                    let height = bounds.height / 2
                    let y = (bounds.midY - (height / 2))
                    let pivotRect = CGRect(x: bounds.minX, y: y, width: 5, height: height)
                    context.setFillColor(color!)
                    context.addRects([pivotRect])
                    context.fill(pivotRect)
                    
                case 3:
                    
                    if currentSwitch == 1 {

                        //BOTTOM PIVOT TO RIGHT
                        let rect7 = CGRect(x: (frame.width / 2) - (diff), y: (frame.height / 2) - diff, width: posWidth, height: posHeight)
                        context.addEllipse(in: rect7)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect7)
                        
                        let rect8 = CGRect(x: (frame.width / 2) + (diff), y: (frame.height / 2) + diff, width: negWidth, height: negHeight)
                        context.addEllipse(in: rect8)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect8)
                        
                        currentSwitch = 2
                        
                    } else {
                        
                        //BOTTOM PIVOT TO LEFT
                        let rect5 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) - diff, width: posWidth, height: posHeight)
                        context.addEllipse(in: rect5)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect5)
                        
                        let rect6 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) + diff , width: negWidth, height: negHeight)
                        context.addEllipse(in: rect6)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect6)
                        
                        currentSwitch = 1
                    }
                    
                    //Bottom pivot
                    let width = bounds.width / 2
                    let x = (bounds.midX - (width / 2))
                    let pivotRect = CGRect(x: x, y: bounds.maxY - 5, width: width, height: 5)
                    context.setFillColor(color!)
                    context.addRects([pivotRect])
                    context.fill(pivotRect)
                    
                case 4:
                    
                    if currentSwitch == 1 {
                        
                        //RIGHT PIVOT TO TOP
                        let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: posWidth, height: posHeight)
                        context.addEllipse(in: rect3)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect3)
                        
                        let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: negWidth, height: negHeight)
                        context.addEllipse(in: rect4)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect4)

                        currentSwitch = 2

                    } else {
                        
                        //RIGHT PIVOT TO BOTTOM
                        let rect7 = CGRect(x: (frame.width / 2) - (diff), y: (frame.height / 2) - diff, width: posWidth, height: posHeight)
                        context.addEllipse(in: rect7)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect7)
                        
                        let rect8 = CGRect(x: (frame.width / 2) + (diff), y: (frame.height / 2) + diff, width: negWidth, height: negHeight)
                        context.addEllipse(in: rect8)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect8)
                        
                        currentSwitch = 1
                    }
                    
                    //Right Pivot
                    
                    let height = bounds.height / 2
                    let y = (bounds.midY - (height / 2))
                    let pivotRect = CGRect(x: bounds.maxX - 5, y: y, width: 5, height: height)
                    context.setFillColor(color!)
                    context.addRects([pivotRect])
                    context.fill(pivotRect)

                default:
                    break
                }
                
        case .doubleElbow:
            
            if currentSwitch == 1 {
                
                guard let context = UIGraphicsGetCurrentContext() else { return }
                
                let diff = frame.height / 10
                
                let eclipseHeight1 = frame.height + diff
                let eclipseWidth1 = frame.width + diff
                let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth1, height: eclipseHeight1)
                context.addEllipse(in: rect1)
                context.setFillColor(UIColor.red.cgColor)
                context.fillEllipse(in: rect1)

                let eclipseHeight2 = frame.height - diff
                let eclipseWidth2 = frame.width - diff
                let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.addEllipse(in: rect2)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect2)
                
                let eclipseHeight3 = frame.height + diff
                let eclipseWidth3 = frame.width + diff
                let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: eclipseWidth3, height: eclipseHeight3)
                context.addEllipse(in: rect3)
                context.setFillColor(UIColor.purple.cgColor)
                context.fillEllipse(in: rect3)
                
                let eclipseHeight4 = frame.height - diff
                let eclipseWidth4 = frame.width - diff
                let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: eclipseWidth4, height: eclipseHeight4)
                context.addEllipse(in: rect4)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect4)
                
                currentSwitch = 2
                
            } else {
                
                guard let context = UIGraphicsGetCurrentContext() else { return }
                
                let diff = frame.height / 10

                let eclipseHeight3 = frame.height + diff
                let eclipseWidth3 = frame.width + diff
                let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: eclipseWidth3, height: eclipseHeight3)
                context.addEllipse(in: rect3)
                context.setFillColor(UIColor.purple.cgColor)
                context.fillEllipse(in: rect3)
                
                let eclipseHeight4 = frame.height - diff
                let eclipseWidth4 = frame.width - diff
                let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: eclipseWidth4, height: eclipseHeight4)
                context.addEllipse(in: rect4)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect4)
                
                let eclipseHeight1 = frame.height + diff
                let eclipseWidth1 = frame.width + diff
                let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth1, height: eclipseHeight1)
                context.addEllipse(in: rect1)
                context.setFillColor(UIColor.red.cgColor)
                context.fillEllipse(in: rect1)

                let eclipseHeight2 = frame.height - diff
                let eclipseWidth2 = frame.width - diff
                let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.addEllipse(in: rect2)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect2)
                
                currentSwitch = 1
            }
            
        case .quadBox:
              
              if currentSwitch == 1 {
                  
                guard let context = UIGraphicsGetCurrentContext() else { return }
                
                let diff = frame.height / 10

                let eclipseHeight3 = frame.height + diff
                let eclipseWidth3 = frame.width + diff
                let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: eclipseWidth3, height: eclipseHeight3)
                context.addEllipse(in: rect3)
                context.setFillColor(UIColor.purple.cgColor)
                context.fillEllipse(in: rect3)
                
                let eclipseHeight4 = frame.height - diff
                let eclipseWidth4 = frame.width - diff
                let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: eclipseWidth4, height: eclipseHeight4)
                context.addEllipse(in: rect4)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect4)

                let eclipseHeight5 = frame.height + diff
                let eclipseWidth5 = frame.width + diff
                let rect5 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) - diff, width: eclipseWidth5, height: eclipseHeight5)
                context.addEllipse(in: rect5)
                context.setFillColor(UIColor.green.cgColor)
                context.fillEllipse(in: rect5)
                
                let eclipseHeight6 = frame.height - diff
                let eclipseWidth6 = frame.width - diff
                let rect6 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) + diff , width: eclipseWidth6, height: eclipseHeight6)
                context.addEllipse(in: rect6)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect6)

                let eclipseHeight1 = frame.height + diff
                let eclipseWidth1 = frame.width + diff
                let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth1, height: eclipseHeight1)
                context.addEllipse(in: rect1)
                context.setFillColor(UIColor.red.cgColor)
                context.fillEllipse(in: rect1)
                
                let eclipseHeight2 = frame.height - diff
                let eclipseWidth2 = frame.width - diff
                let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.addEllipse(in: rect2)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect2)
                
                let eclipseHeight7 = frame.height + diff
                let eclipseWidth7 = frame.width + diff
                let rect7 = CGRect(x: (frame.width / 2) - (diff), y: (frame.height / 2) - diff, width: eclipseWidth7, height: eclipseHeight7)
                context.addEllipse(in: rect7)
                context.setFillColor(UIColor.blue.cgColor)
                context.fillEllipse(in: rect7)
                
                let eclipseHeight8 = frame.height - diff
                let eclipseWidth8 = frame.width - diff
                let rect8 = CGRect(x: (frame.width / 2) + (diff), y: (frame.height / 2) + diff, width: eclipseWidth8, height: eclipseHeight8)
                context.addEllipse(in: rect8)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect8)
                
                  currentSwitch = 2
                
              } else if currentSwitch == 2 {
                  
                guard let context = UIGraphicsGetCurrentContext() else { return }
                
                let diff = frame.height / 10
                
                let eclipseHeight1 = frame.height + diff
                let eclipseWidth1 = frame.width + diff
                let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth1, height: eclipseHeight1)
                context.addEllipse(in: rect1)
                context.setFillColor(UIColor.red.cgColor)
                context.fillEllipse(in: rect1)
                
                let eclipseHeight2 = frame.height - diff
                let eclipseWidth2 = frame.width - diff
                let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.addEllipse(in: rect2)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect2)
                
                let eclipseHeight7 = frame.height + diff
                let eclipseWidth7 = frame.width + diff
                let rect7 = CGRect(x: (frame.width / 2) - (diff), y: (frame.height / 2) - diff, width: eclipseWidth7, height: eclipseHeight7)
                context.addEllipse(in: rect7)
                context.setFillColor(UIColor.blue.cgColor)
                context.fillEllipse(in: rect7)
                  
                let eclipseHeight8 = frame.height - diff
                let eclipseWidth8 = frame.width - diff
                let rect8 = CGRect(x: (frame.width / 2) + (diff), y: (frame.height / 2) + diff, width: eclipseWidth8, height: eclipseHeight8)
                context.addEllipse(in: rect8)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect8)
                  
                let eclipseHeight3 = frame.height + diff
                let eclipseWidth3 = frame.width + diff
                let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: eclipseWidth3, height: eclipseHeight3)
                context.addEllipse(in: rect3)
                context.setFillColor(UIColor.purple.cgColor)
                context.fillEllipse(in: rect3)
                
                let eclipseHeight4 = frame.height - diff
                let eclipseWidth4 = frame.width - diff
                let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: eclipseWidth4, height: eclipseHeight4)
                context.addEllipse(in: rect4)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect4)
                
                let eclipseHeight5 = frame.height + diff
                let eclipseWidth5 = frame.width + diff
                let rect5 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) - diff, width: eclipseWidth5, height: eclipseHeight5)
                context.addEllipse(in: rect5)
                context.setFillColor(UIColor.green.cgColor)
                context.fillEllipse(in: rect5)
                
                let eclipseHeight6 = frame.height - diff
                let eclipseWidth6 = frame.width - diff
                let rect6 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) + diff , width: eclipseWidth6, height: eclipseHeight6)
                context.addEllipse(in: rect6)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect6)
                
                  currentSwitch = 1
                
               }
            
            case .diagElbow:
                               
                guard let context = UIGraphicsGetCurrentContext() else { return }
                let diff = frame.height / 10
                let posHeight = frame.height + diff
                let posWidth = frame.width + diff
                let negHeight = frame.height - diff
                let negWidth = frame.width - diff
                
                switch version {
                
                case 1, 3:
                    
                    if currentSwitch == 1 {
                        
                        //RIGHT PIVOT TO TOP SIDE
                        let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: posWidth, height: posHeight)
                        context.addEllipse(in: rect3)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect3)
                        
                        let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: negWidth, height: negHeight)
                        context.addEllipse(in: rect4)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect4)
                        
                        //LEFT PIVOT TO BOTTOM SIDE
                        let rect5 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) - diff, width: posWidth, height: posHeight)
                        context.addEllipse(in: rect5)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect5)
                        
                        let rect6 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) + diff , width: negWidth, height: negHeight)
                        context.addEllipse(in: rect6)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect6)
                        
                        currentSwitch = 2
                        
                    } else if currentSwitch == 2 {
                        
                        //LEFT PIVOT TO TOP SIDE
                        let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: posWidth, height: posHeight)
                        context.addEllipse(in: rect1)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect1)
                        
                        let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: negWidth, height: negHeight)
                        context.addEllipse(in: rect2)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect2)
                        
                        //RIGHT PIVOT TO BOTTOM SIDE
                        let rect7 = CGRect(x: (frame.width / 2) - (diff), y: (frame.height / 2) - diff, width: posWidth, height: posHeight)
                        context.addEllipse(in: rect7)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect7)
                        
                        let rect8 = CGRect(x: (frame.width / 2) + (diff), y: (frame.height / 2) + diff, width: negWidth, height: negHeight)
                        context.addEllipse(in: rect8)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect8)
                        
                        currentSwitch = 1
                     }
                    
                    //Left Pivot
                    let height = bounds.height / 2
                    let y = (bounds.midY - (height / 2))
                    let pivotRect = CGRect(x: bounds.minX, y: y, width: 5, height: height)
                    context.setFillColor(color!)
                    context.addRects([pivotRect])
                    context.fill(pivotRect)
                    
                    //RIGHT PIVOT
                    let pivotRect2 = CGRect(x: bounds.maxX - 5, y: y, width: 5, height: height)
                    context.setFillColor(color!)
                    context.addRects([pivotRect2])
                    context.fill(pivotRect2)
                    
                case 2, 4:
                    
                    if currentSwitch == 1 {
                        
                        //TOP PIVOT TO LEFT SIDE
                        let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: posWidth, height: posHeight)
                        context.addEllipse(in: rect1)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect1)
                        
                        let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: negWidth, height: negHeight)
                        context.addEllipse(in: rect2)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect2)
                        
                        //BOTTOM PIVOT TO RIGHT SIDE
                        let rect7 = CGRect(x: (frame.width / 2) - (diff), y: (frame.height / 2) - diff, width: posWidth, height: posHeight)
                        context.addEllipse(in: rect7)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect7)
                        
                        let rect8 = CGRect(x: (frame.width / 2) + (diff), y: (frame.height / 2) + diff, width: negWidth, height: negHeight)
                        context.addEllipse(in: rect8)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect8)
                        
                        currentSwitch = 2
                        
                    } else if currentSwitch == 2 {
                        
                        //TOP PIVOT TO RIGHT SIDE
                        let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: posWidth, height: posHeight)
                        context.addEllipse(in: rect3)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect3)
                        
                        let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: negWidth, height: negHeight)
                        context.addEllipse(in: rect4)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect4)
                        
                        //BOTTOM PIVOT TO LEFT SIDE
                        let rect5 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) - diff, width: posWidth, height: posHeight)
                        context.addEllipse(in: rect5)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect5)
                        
                        let rect6 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) + diff , width: negWidth, height: negHeight)
                        context.addEllipse(in: rect6)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect6)
                        
                        currentSwitch = 1
                     }
                    
                    //TOP PIVOT
                    let width = bounds.width / 2
                    let x = (bounds.midX - (width / 2))
                    let pivotRect = CGRect(x: x, y: bounds.minY, width: width, height: 5)
                    context.setFillColor(color!)
                    context.addRects([pivotRect])
                    context.fill(pivotRect)
                    
                    //Bottom pivot
                    let pivotRect2 = CGRect(x: x, y: bounds.maxY - 5, width: width, height: 5)
                    context.setFillColor(color!)
                    context.addRects([pivotRect2])
                    context.fill(pivotRect2)
                    
                default:
                    break
                }
            
        case .sword:
            
            switch currentSwitch {
            case 1:
                guard let context = UIGraphicsGetCurrentContext() else { return }
                
                let diff = frame.height / 10

                let eclipseHeight1 = frame.height + diff
                let eclipseWidth1 = frame.width + diff
                let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth1, height: eclipseHeight1)
                context.addEllipse(in: rect1)
                context.setFillColor(UIColor.red.cgColor)
                context.fillEllipse(in: rect1)

                let eclipseHeight2 = frame.height - diff
                let eclipseWidth2 = frame.width - diff
                let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.addEllipse(in: rect2)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect2)
                
                let eclipseHeight3 = frame.height + diff
                let eclipseWidth3 = frame.width + diff
                let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: eclipseWidth3, height: eclipseHeight3)
                context.addEllipse(in: rect3)
                context.setFillColor(UIColor.purple.cgColor)
                context.fillEllipse(in: rect3)
                
                let eclipseHeight4 = frame.height - diff
                let eclipseWidth4 = frame.width - diff
                let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: eclipseWidth4, height: eclipseHeight4)
                context.addEllipse(in: rect4)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect4)
                
                let width = diff * 2
                let x = ((frame.width / 2) - (diff / 2)) - (width / 4)
                let rect5 = CGRect(x: x, y: 0, width: width, height: frame.height)
                context.setFillColor(UIColor.blue.cgColor)
                context.addRects([rect5])
                context.fill(rect5)
                
                currentSwitch += 1
                
            case 2:
                
                guard let context = UIGraphicsGetCurrentContext() else { return }
                
                let diff = frame.height / 10
                
                let eclipseHeight3 = frame.height + diff
                let eclipseWidth3 = frame.width + diff
                let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: eclipseWidth3, height: eclipseHeight3)
                context.addEllipse(in: rect3)
                context.setFillColor(UIColor.purple.cgColor)
                context.fillEllipse(in: rect3)
                
                let eclipseHeight4 = frame.height - diff
                let eclipseWidth4 = frame.width - diff
                let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: eclipseWidth4, height: eclipseHeight4)
                context.addEllipse(in: rect4)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect4)
                
                let width = diff * 2
                let x = ((frame.width / 2) - (diff / 2)) - (width / 4)
                let rect5 = CGRect(x: x, y: 0, width: width, height: frame.height)
                context.setFillColor(UIColor.blue.cgColor)
                context.addRects([rect5])
                context.fill(rect5)
                
                let eclipseHeight1 = frame.height + diff
                let eclipseWidth1 = frame.width + diff
                let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth1, height: eclipseHeight1)
                context.addEllipse(in: rect1)
                context.setFillColor(UIColor.red.cgColor)
                context.fillEllipse(in: rect1)

                let eclipseHeight2 = frame.height - diff
                let eclipseWidth2 = frame.width - diff
                let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.addEllipse(in: rect2)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect2)
                
                currentSwitch += 1
                
            case 3:
                guard let context = UIGraphicsGetCurrentContext() else { return }
                
                let diff = frame.height / 10
                
                let width = diff * 2
                let x = ((frame.width / 2) - (diff / 2)) - (width / 4)
                let rect5 = CGRect(x: x, y: 0, width: width, height: frame.height)
                context.setFillColor(UIColor.blue.cgColor)
                context.addRects([rect5])
                context.fill(rect5)
                
                let eclipseHeight1 = frame.height + diff
                let eclipseWidth1 = frame.width + diff
                let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth1, height: eclipseHeight1)
                context.addEllipse(in: rect1)
                context.setFillColor(UIColor.red.cgColor)
                context.fillEllipse(in: rect1)

                let eclipseHeight2 = frame.height - diff
                let eclipseWidth2 = frame.width - diff
                let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.addEllipse(in: rect2)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect2)
                
                let eclipseHeight3 = frame.height + diff
                let eclipseWidth3 = frame.width + diff
                let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: eclipseWidth3, height: eclipseHeight3)
                context.addEllipse(in: rect3)
                context.setFillColor(UIColor.purple.cgColor)
                context.fillEllipse(in: rect3)
                
                let eclipseHeight4 = frame.height - diff
                let eclipseWidth4 = frame.width - diff
                let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: eclipseWidth4, height: eclipseHeight4)
                context.addEllipse(in: rect4)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect4)
                
                currentSwitch = 1
                
            default:
                break
            }
            
        case .cross:
            
                switch currentSwitch {
                
                case 1:
                    
                    guard let context = UIGraphicsGetCurrentContext() else { return }

                    let width = frame.width
                    let height = frame.height / 4.5
                    let x1:CGFloat = 0.0
                    let y1 = ((frame.height - height) / 2)
                    
                    let width2 = frame.width / 4.5
                    let height2 = frame.height
                    let y2:CGFloat = 0.0
                    let x2 = ((frame.width - width2) / 2)

                    let rect2 = CGRect(x: x2, y: y2, width: width2, height: height2)
                    context.setFillColor(UIColor.blue.cgColor)
                    context.addRects([rect2])
                    context.fill(rect2)
                    
                    let rect1 = CGRect(x: x1, y: y1, width: width, height: height)
                    context.setFillColor(UIColor.green.cgColor)
                    context.addRects([rect1])
                    context.fill(rect1)
            
                    currentSwitch = 2
                    
                case 2:
                    
                    guard let context = UIGraphicsGetCurrentContext() else { return }
                    
                    let width = frame.width
                    let height = frame.height / 4.5
                    let x1:CGFloat = 0.0
                    let y1 = ((frame.height - height) / 2)
                    
                    let width2 = frame.width / 4.5
                    let height2 = frame.height
                    let y2:CGFloat = 0.0
                    let x2 = ((frame.width - width2) / 2)
                    
                    let rect1 = CGRect(x: x1, y: y1, width: width, height: height)
                    context.setFillColor(UIColor.green.cgColor)
                    context.addRects([rect1])
                    context.fill(rect1)
                    
                    let rect2 = CGRect(x: x2, y: y2, width: width2, height: height2)
                    context.setFillColor(UIColor.blue.cgColor)
                    context.addRects([rect2])
                    context.fill(rect2)
                    
                    currentSwitch = 1
                    
                default:
                    break
                }
                
                
        case .ball:
            
            guard let context = UIGraphicsGetCurrentContext() else { return }
            let eclipseHeight1 = frame.height / 5
            let eclipseWidth1 = frame.width / 5
            let rect1 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
            context.addEllipse(in: rect1)
            context.setFillColor(UIColor.systemPink.cgColor)
            context.fillEllipse(in: rect1)

//        default:
//            break
        }
    }
}

enum Shape {
    
    case elbow
    case doubleElbow
    case diagElbow
    case sword
    case cross
    case quadBox
    case regular
    case ball
}





