
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
    
    var colors = [CGColor]()
        
    var switches = Int()
    
    var currentSwitch = Int()
    
    var isLocked = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, piece: Piece) {

        
        for color in piece.colors {
            
            self.colors.append(color.cgColor)
        }
        
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.name = piece.shape
        self.version = piece.version
        self.isLocked = piece.isLocked
        
        switch name {
        case .elbow:
            switches = 2
            currentSwitch = piece.currentSwitch
//            self.version = piece.version
            
        case .doubleElbow:
            switches = 2
            currentSwitch = piece.currentSwitch

        case .sword:
            switches = 3
            currentSwitch = piece.currentSwitch
            
        case .cross:
            switches = 2
            currentSwitch = piece.currentSwitch

        case .stick:
            switches = 1
            currentSwitch = piece.currentSwitch
            
            
        case .quadBox:
            switches = 2
            currentSwitch = piece.currentSwitch
            
        case .diagElbow:
            switches = 2
            currentSwitch = piece.currentSwitch
//            self.version = piece.version

        default:
            break
        }
    }
    
    func setLock(context: CGContext) {
        let w = frame.width * 0.3
        let h = frame.height * 0.3
        let x = (frame.width - w) / 2
        let y = (frame.height - h) / 2
        let rect1 = CGRect(x: x, y: y, width: w, height: h)

        context.addRect(rect1)
        context.setFillColor(UIColor.darkGray.cgColor)
        context.fill(rect1)
        
        let lineWidth:CGFloat = 8.0

        let startPoint = CGPoint(x: ((frame.width - w) / 2) + lineWidth, y: (frame.height - h) / 2)
        let point2 = CGPoint(x: (frame.width - w) / 2, y: frame.height / 6)
        let point3 = CGPoint(x: (frame.width + w) / 2, y: frame.height / 6)
        let point4 = CGPoint(x: ((frame.width + w) / 2) - lineWidth, y: (frame.height - h) / 2)
        
        context.setStrokeColor(UIColor.darkGray.cgColor)
        context.setLineWidth(lineWidth)
        context.beginPath()
        context.move(to: startPoint)
        context.addCurve(to: point4, control1: point2, control2: point3)
        context.strokePath()
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let path = UIBezierPath()
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let topCenterPoint = CGPoint(x: frame.width / 2, y: 0)
        let bottomCenterPoint = CGPoint(x: frame.width / 2, y: frame.height)
        let leftCenterPoint = CGPoint(x: 0, y: frame.height / 2)
        let rightCenterPoint = CGPoint(x: frame.width, y: frame.height / 2)
        
        context.setLineWidth(frame.height / 4)
        context.setFillColor(colors[0])
        context.setStrokeColor(colors[0])
        
        
        switch name {
        
        
        case .stick:
            
            switch version {
            
            case 1, 3:
                
                let width = frame.width
                let height = frame.height / 4
                let x1:CGFloat = 0.0
                let y1 = ((frame.height - height) / 2)
                
                
                let rect1 = CGRect(x: x1, y: y1, width: width, height: height)
                context.setFillColor(colors[1])
                context.addRects([rect1])
                context.fill(rect1)
                
                let height3:CGFloat = height / 10
                context.setFillColor(UIColor.black.cgColor)

                let borderline1 = CGRect(x: 0, y: (frame.height / 2) - (height / 2) - height3, width: frame.width, height: height3)
                let borderline2 = CGRect(x: 0, y: (frame.height / 2) + (height / 2), width: frame.width, height: height3)
                context.addRects([borderline1, borderline2])
                context.fill(borderline1)
                context.fill(borderline2)
                
                
                currentSwitch = 2
                
            case 2, 4:
                
                let width2 = frame.width / 4
                let height2 = frame.height
                let y2:CGFloat = 0.0
                let x2 = ((frame.width - width2) / 2)
                
                
                let rect2 = CGRect(x: x2, y: y2, width: width2, height: height2)
                context.setFillColor(colors[0])
                context.addRects([rect2])
                context.fill(rect2)
                
                let width3:CGFloat = width2 / 10
                context.setFillColor(UIColor.black.cgColor)

                let borderline1 = CGRect(x: (frame.width / 2) - (width2 / 2) - width3, y: 0, width: width3, height: frame.height)
                let borderline2 = CGRect(x: (frame.width / 2) + (width2 / 2), y: 0, width: width3, height: frame.height)
                context.addRects([borderline1, borderline2])
                context.fill(borderline1)
                context.fill(borderline2)
                
                
                currentSwitch = 1
                
            default:
                break
            }
            
            
            
            
        case .regular:
            
//            guard let context = UIGraphicsGetCurrentContext() else { return }
            let w = frame.width / 10 * 9
            let h = frame.height / 10 * 9
            let x = (frame.width - w) / 2
            let y = (frame.height - h) / 2
            let rect1 = CGRect(x: x, y: y, width: w, height: h)
//            context.setFillColor(UIColor.black.cgColor)
            context.addRects([rect1])
            context.fill(rect1)

            if isLocked == true {
                
                setLock(context: context)
            }
            
            
            
        case .elbow:
            
                switch version {
                
                case 1:
                    
                    // TOP PIVOT TO LEFT SIDE
                    if currentSwitch == 1 {
                    
                        drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint)
                        
                        
                        currentSwitch = 2
                    
                    // TOP PIVOT TO RIGHT SIDE
                    } else if currentSwitch == 2 {
                        
                        drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: rightCenterPoint)
                        
                        
                        currentSwitch = 1
                    }
                    
                    //TOP PIVOT
                    let width = bounds.width / 2
                    let x = (bounds.midX - (width / 2))
                    let pivotRect = CGRect(x: x, y: bounds.minY, width: width, height: bounds.height / 10)
//                    context.setFillColor(colors?[0] ?? UIColor.systemTeal.cgColor)
                    context.addRects([pivotRect])
                    context.fill(pivotRect)
                    
                case 2:
                    
                    if currentSwitch == 1 {
                        
                        //LEFT PIVOT TO BOTTOM
                        drawPath(path: path, context: context, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint)
                        
                        currentSwitch = 2
                    } else if currentSwitch == 2 {
                        
                        //LEFT PIVOT TO TOP
                        drawPath(path: path, context: context, pivotPoint: leftCenterPoint, center: center, endPoint: topCenterPoint)
                        
                        currentSwitch = 1
                    }
                    
                    //Left Pivot
                    let height = bounds.height / 2
                    let y = (bounds.midY - (height / 2))
                    let pivotRect = CGRect(x: bounds.minX, y: y, width: bounds.width / 10, height: height)
//                    context.setFillColor(colors?[0] ?? UIColor.systemTeal.cgColor)
                    context.addRects([pivotRect])
                    context.fill(pivotRect)
                    
                case 3:
                    
                    if currentSwitch == 1 {

                        //BOTTOM PIVOT TO RIGHT
                        drawPath(path: path, context: context, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint)
                        
                        currentSwitch = 2
                        
                    } else if currentSwitch == 2  {
                        
                        //BOTTOM PIVOT TO LEFT
                        drawPath(path: path, context: context, pivotPoint: bottomCenterPoint, center: center, endPoint: leftCenterPoint)
                        
                        currentSwitch = 1
                    }
                    
                    //Bottom pivot
                    let width = bounds.width / 2
                    let x = (bounds.midX - (width / 2))
                    let pivotRect = CGRect(x: x, y: bounds.maxY - (bounds.height / 10), width: width, height: bounds.height / 10)
//                    context.setFillColor(colors?[0] ?? UIColor.systemTeal.cgColor)
                    context.addRects([pivotRect])
                    context.fill(pivotRect)
                    
                case 4:
                    
                    if currentSwitch == 1 {
                        
                        //RIGHT PIVOT TO TOP
                        drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint)

                        currentSwitch = 2

                    } else if currentSwitch == 2  {
                        
                        //RIGHT PIVOT TO BOTTOM
                        drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: bottomCenterPoint)
                        
                        currentSwitch = 1
                    }
                    
                    //Right Pivot
                    
                    let height = bounds.height / 2
                    let y = (bounds.midY - (height / 2))
                    let pivotRect = CGRect(x: bounds.maxX - (bounds.width / 10), y: y, width: bounds.width / 10, height: height)
                    context.addRects([pivotRect])
                    context.fill(pivotRect)

                default:
                    break
                }
                
        case .doubleElbow:
            
            if currentSwitch == 1 {
                
//                guard let context = UIGraphicsGetCurrentContext() else { return }
                
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
                  
//                guard let context = UIGraphicsGetCurrentContext() else { return }
                
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
                guard let context2 = UIGraphicsGetCurrentContext() else {return}

                switch version {
                
                case 1, 3:
                    
                    let height = bounds.height / 2
                    let y = (bounds.midY - (height / 2))
                    let pivotRect2 = CGRect(x: bounds.minX, y: y, width: bounds.width / 10, height: height)
                    let pivotRect = CGRect(x: bounds.maxX - (bounds.height / 10), y: y, width: bounds.width / 10, height: height)
                    let path2 = UIBezierPath()

                    
                    if currentSwitch == 1 {
                        
                        //RIGHT PIVOT TO TOP SIDE
                        context.setFillColor(colors[0]) // FOR V2
                        context.setStrokeColor(colors[0])
                        drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint)
                        context.addRects([pivotRect])
                        context.fill(pivotRect)
                        
                        //LEFT PIVOT TO BOTTOM SIDE
                        context2.setFillColor(colors[1]) // FOR V2
                        context2.setStrokeColor(colors[1])
                        drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint)
                        context2.addRects([pivotRect2])
                        context2.fill(pivotRect2)
                        
                        currentSwitch = 2
                        
                    } else if currentSwitch == 2 {
                        
                        //LEFT PIVOT TO TOP SIDE
                        context.setFillColor(colors[1])
                        context.setStrokeColor(colors[1])
                        drawPath(path: path, context: context, pivotPoint: leftCenterPoint, center: center, endPoint: topCenterPoint)
                        context.addRects([pivotRect2])
                        context.fill(pivotRect2)

                        //RIGHT PIVOT TO BOTTOM SIDE
                        context2.setFillColor(colors[0])
                        context2.setStrokeColor(colors[0])
                        drawPath(path: path2, context: context2, pivotPoint: rightCenterPoint, center: center, endPoint: bottomCenterPoint)
                        context2.addRects([pivotRect])
                        context2.fill(pivotRect)
                        
                        currentSwitch = 1
                     }
                    
                case 2, 4:
                    
                    let width = bounds.width / 2
                    let x = (bounds.midX - (width / 2))
                    let pivotRect2 = CGRect(x: x, y: bounds.minY, width: width, height: bounds.height / 10)
                    let pivotRect = CGRect(x: x, y: bounds.maxY - (bounds.height / 10), width: width, height: bounds.height / 10)
                    let path2 = UIBezierPath()

                    if currentSwitch == 1 {
                        
                        //TOP PIVOT TO LEFT SIDE
                        context.setFillColor(colors[0])
                        context.setStrokeColor(colors[0])
                        drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint)
                        context.addRects([pivotRect2])
                        context.fill(pivotRect2)
                        
                        //BOTTOM PIVOT TO RIGHT SIDE
                        context2.setFillColor(colors[1])
                        context2.setStrokeColor(colors[1])
                        drawPath(path: path2, context: context2, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint)
                        context2.addRects([pivotRect])
                        context2.fill(pivotRect)
                        
                        currentSwitch = 2

                    } else if currentSwitch == 2 {
                        
                        //BOTTOM PIVOT TO LEFT SIDE
                       
                        context.setFillColor(colors[1])
                        context.setStrokeColor(colors[1])
                        drawPath(path: path, context: context, pivotPoint: bottomCenterPoint, center: center, endPoint: leftCenterPoint)
                        context.addRects([pivotRect])
                        context.fill(pivotRect)
                        
                        //TOP PIVOT TO RIGHT SIDE
                        context2.setFillColor(colors[0])
                        context2.setStrokeColor(colors[0])
                        drawPath(path: path2, context: context2, pivotPoint: topCenterPoint, center: center, endPoint: rightCenterPoint)
                        context2.addRects([pivotRect2])
                        context2.fill(pivotRect2)
                        
                        currentSwitch = 1
                     }
                    
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
                    
                    let width = frame.width
                    let height = frame.height / 4
                    let x1:CGFloat = 0.0
                    let y1 = ((frame.height - height) / 2)
                    
                    let width2 = frame.width / 4
                    let height2 = frame.height
                    let y2:CGFloat = 0.0
                    let x2 = ((frame.width - width2) / 2)

                    let rect2 = CGRect(x: x2, y: y2, width: width2, height: height2)
                    context.setFillColor(colors[0])
                    context.addRects([rect2])
                    context.fill(rect2)
                    
                    let rect1 = CGRect(x: x1, y: y1, width: width, height: height)
                    context.setFillColor(colors[1])
                    context.addRects([rect1])
                    context.fill(rect1)
                    
                    let height3:CGFloat = height / 10
                    context.setFillColor(UIColor.black.cgColor)

                    let borderline1 = CGRect(x: 0, y: (frame.height / 2) - (height / 2) - height3, width: frame.width, height: height3)
                    let borderline2 = CGRect(x: 0, y: (frame.height / 2) + (height / 2), width: frame.width, height: height3)
                    context.addRects([borderline1, borderline2])
                    context.fill(borderline1)
                    context.fill(borderline2)

                    currentSwitch = 2
                    
                case 2:
                    
                    let width = frame.width
                    let height = frame.height / 4
                    let x1:CGFloat = 0.0
                    let y1 = ((frame.height - height) / 2)
                    
                    let width2 = frame.width / 4
                    let height2 = frame.height
                    let y2:CGFloat = 0.0
                    let x2 = ((frame.width - width2) / 2)
                    
                    let rect1 = CGRect(x: x1, y: y1, width: width, height: height)
                    context.setFillColor(colors[1])
                    context.addRects([rect1])
                    context.fill(rect1)
                    
                    let rect2 = CGRect(x: x2, y: y2, width: width2, height: height2)
                    context.setFillColor(colors[0])
                    context.addRects([rect2])
                    context.fill(rect2)
                    
                    let width3:CGFloat = width2 / 10
                    context.setFillColor(UIColor.black.cgColor)

                    let borderline1 = CGRect(x: (frame.width / 2) - (width2 / 2) - width3, y: 0, width: width3, height: frame.height)
                    let borderline2 = CGRect(x: (frame.width / 2) + (width2 / 2), y: 0, width: width3, height: frame.height)
                    context.addRects([borderline1, borderline2])
                    context.fill(borderline1)
                    context.fill(borderline2)
                    
                    currentSwitch = 1
                    
                default:
                    break
                }
                
                
        case .ball:
            
//            guard let context = UIGraphicsGetCurrentContext() else { return }
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
    
    func drawPath(path: UIBezierPath, context: CGContext, pivotPoint: CGPoint, center: CGPoint, endPoint: CGPoint) {

        
        path.move(to: pivotPoint)
        path.addQuadCurve(to: endPoint, controlPoint: center)
        context.addPath(path.cgPath)
        context.strokePath()
        
        
        
        
        
        
    }
    
    
}


class BallView : UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    override func draw(_ rect: CGRect) {

    
    
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let eclipseHeight1 = frame.height / 5
        let eclipseWidth1 = frame.width / 5
        let rect1 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
        context.addEllipse(in: rect1)
        context.setFillColor(UIColor.systemPink.cgColor)
        context.fillEllipse(in: rect1)
    
    }
    
}

enum Shape {
    
    case elbow
    case doubleElbow
    case diagElbow
    case sword
    case cross
    case stick
    case quadBox
    case regular
    case ball
}





