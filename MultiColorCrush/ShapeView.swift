
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
    
    var shape:Shape = .regular
    
    var version = Int()
    
    var colors = [CGColor]()
        
    var switches = Int()
    
    var currentSwitch = Int()
    
    var isLocked = false
    
    var opening = String()
    
    var nextPiece: Piece?
    
//    var piece = Piece()
    
    
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
        
        
        
        self.shape = piece.shape
        self.version = piece.version
        self.isLocked = piece.isLocked
        self.opening = piece.opening
        
        if let nextPieceX = piece.nextPiece {
            self.nextPiece = nextPieceX
        }
//        self.piece = piece
        
        
        switch shape {
        case .elbow:
            switches = 2
            currentSwitch = piece.currentSwitch
            self.backgroundColor = UIColor.clear

//            self.version = piece.version
            
        case .cross:
            switches = 2
            currentSwitch = piece.currentSwitch
            self.backgroundColor = UIColor.clear


        case .stick:
            switches = 1
            currentSwitch = piece.currentSwitch
            self.backgroundColor = UIColor.clear

            
        case .diagElbow:
            switches = 2
            currentSwitch = piece.currentSwitch
            self.backgroundColor = UIColor.clear

//            self.version = piece.version

        case .entrance, .exit, .pieceMaker, .wall:
            
            
            self.backgroundColor = UIColor.darkGray

            
        default:
            break
        }
    }
    
    func setLock(context: CGContext) {
        
        let distanceFromSides = frame.width / 10
        let screwWidthAndHeight = frame.width / 10
        let color = UIColor.black.cgColor
        
        
        let topLeftCorner = CGPoint(x: distanceFromSides, y: distanceFromSides)
        let topLeftRect = CGRect(x: topLeftCorner.x, y: topLeftCorner.y, width: screwWidthAndHeight, height: screwWidthAndHeight)
        context.addRect(topLeftRect)
        context.setFillColor(color)
        context.fill(topLeftRect)
        
        
        let topRightCorner = CGPoint(x: frame.width - distanceFromSides - screwWidthAndHeight, y: distanceFromSides)
        let topRightRect = CGRect(x: topRightCorner.x, y: topRightCorner.y, width: screwWidthAndHeight, height: screwWidthAndHeight)
        context.addRect(topRightRect)
        context.setFillColor(color)
        context.fill(topRightRect)
        
        
        let bottomLeftCorner = CGPoint(x: distanceFromSides, y: frame.height - distanceFromSides - screwWidthAndHeight)
        let bottomLeftRect = CGRect(x: bottomLeftCorner.x, y: bottomLeftCorner.y, width: screwWidthAndHeight, height: screwWidthAndHeight)
        context.addRect(bottomLeftRect)
        context.setFillColor(color)
        context.fill(bottomLeftRect)
        
        
        let bottomRightCorner = CGPoint(x: frame.width - distanceFromSides - screwWidthAndHeight, y: frame.height - distanceFromSides - screwWidthAndHeight)
        let bottomRightRect = CGRect(x: bottomRightCorner.x, y: bottomRightCorner.y, width: screwWidthAndHeight, height: screwWidthAndHeight)
        context.addRect(bottomRightRect)
        context.setFillColor(color)
        context.fill(bottomRightRect)
        
        
        
        
//        let w = frame.width * 0.3
//        let h = frame.height * 0.3
//        let x = (frame.width - w) / 2
//        let y = (frame.height - h) / 2
//        let rect1 = CGRect(x: x, y: y, width: w, height: h)
//
//        context.addRect(rect1)
//        context.setFillColor(UIColor.darkGray.cgColor)
//        context.fill(rect1)
//
//        let lineWidth:CGFloat = 8.0
//
//        let startPoint = CGPoint(x: ((frame.width - w) / 2) + lineWidth, y: (frame.height - h) / 2)
//        let point2 = CGPoint(x: (frame.width - w) / 2, y: frame.height / 6)
//        let point3 = CGPoint(x: (frame.width + w) / 2, y: frame.height / 6)
//        let point4 = CGPoint(x: ((frame.width + w) / 2) - lineWidth, y: (frame.height - h) / 2)
//
//        context.setStrokeColor(UIColor.darkGray.cgColor)
//        context.setLineWidth(lineWidth)
//        context.beginPath()
//        context.move(to: startPoint)
//        context.addCurve(to: point4, control1: point2, control2: point3)
//        context.strokePath()
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        
        
        
        let path = UIBezierPath()
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let topCenterPoint = CGPoint(x: frame.width / 2, y: 0)
        let bottomCenterPoint = CGPoint(x: frame.width / 2, y: frame.height)
        let leftCenterPoint = CGPoint(x: 0, y: frame.height / 2)
        let rightCenterPoint = CGPoint(x: frame.width, y: frame.height / 2)
        
        context.setLineWidth(frame.height / 20)
        context.setStrokeColor(UIColor.black.cgColor)
        
        
        context.beginPath()
        context.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
        context.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        context.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        context.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        context.closePath()
        context.strokePath()
        
        
        
        
        context.setLineWidth(frame.height / 4)
        context.setFillColor(colors[0])
        context.setStrokeColor(colors[0])
        
        
        
        
        
        switch shape {
        
        
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
            let eclipseHeight1 = frame.height / 4
            let eclipseWidth1 = frame.width / 4
            let rect1 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
            context.addEllipse(in: rect1)
            context.setFillColor(UIColor.black.cgColor)
            context.fillEllipse(in: rect1)

            guard let context2 = UIGraphicsGetCurrentContext() else { return }
            let eclipseHeight2 = frame.height / 5
            let eclipseWidth2 = frame.width / 5
            let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
            context2.addEllipse(in: rect2)
                context2.setFillColor(UIColor.black.cgColor)
            context2.fillEllipse(in: rect2)
            
            
//        default:
//            break
        case .entrance, .exit:
            
            
            //TODO: NEED TO Give this the proper look. Also need to hook this up for when the ball noves.
            
            
            //MARK: Make this look like a spoon that the entrance sits on
            
            let eclipseHeight1 = frame.height / 1.4
            let eclipseWidth1 = frame.width / 1.4
            let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
            context.setFillColor(UIColor.black.cgColor)
            context.addEllipse(in: rect2)
            context.fillEllipse(in: rect2)
            
            let eclipseHeight2 = frame.height / 1.5
            let eclipseWidth2 = frame.width / 1.5
            let rect3 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
            context.setFillColor(colors[0])
            context.addEllipse(in: rect3)
            context.fillEllipse(in: rect3)
            
            
            
            switch opening {
            
            
            case "top":
                
//                let eclipseHeight1 = frame.height / 1.75
//                let eclipseWidth1 = frame.width / 1.75
//                let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
//                context.setFillColor(UIColor.black.cgColor)
//                context.addEllipse(in: rect2)
//                context.fillEllipse(in: rect2)
//
//                let eclipseHeight2 = frame.height / 2
//                let eclipseWidth2 = frame.width / 2
//                let rect3 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
//                context.setFillColor(colors[0])
//                context.addEllipse(in: rect3)
//                context.fillEllipse(in: rect3)
                
                let width = frame.width / 4
                let height = frame.height / 2 - (eclipseHeight2 / 2)
                let y1:CGFloat = 0
                let x1 = ((frame.width - width) / 2)
                
                
                let rect1 = CGRect(x: x1, y: y1, width: width, height: height)
                context.setFillColor(colors[0])
                context.addRects([rect1])
                context.fill(rect1)
                
                
                
                
                let width3:CGFloat = width / 10
                context.setFillColor(UIColor.black.cgColor)

                let borderline1 = CGRect(x: (frame.width / 2) - (width / 2) - width3, y: y1, width: width3, height: (frame.height - eclipseHeight2) / 2)
                let borderline2 = CGRect(x: (frame.width / 2) + (width / 2), y: y1, width: width3, height: (frame.height - eclipseHeight2) / 2)
                context.addRects([borderline1, borderline2])
                context.fill(borderline1)
                context.fill(borderline2)
                
            case "bottom":
                
                //JUST COPIED FROM TOP - NEED TO EDIT FOR BOTTOM THEN COMMIT
                
//                let eclipseHeight1 = frame.height / 1.75
//                let eclipseWidth1 = frame.width / 1.75
//                let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
//                context.setFillColor(UIColor.black.cgColor)
//                context.addEllipse(in: rect2)
//                context.fillEllipse(in: rect2)
//
//                let eclipseHeight2 = frame.height / 2
//                let eclipseWidth2 = frame.width / 2
//                let rect3 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
//                context.setFillColor(colors[0])
//                context.addEllipse(in: rect3)
//                context.fillEllipse(in: rect3)
                
                let width = frame.width / 4
                let height = frame.height / 2
                let y1:CGFloat = (frame.height / 2) + (eclipseHeight2 / 2)
                let x1 = ((frame.width - width) / 2)
                
                
                let rect1 = CGRect(x: x1, y: y1, width: width, height: height)
                context.setFillColor(colors[0])
                context.addRects([rect1])
                context.fill(rect1)
                
                
                
                
                let width3:CGFloat = width / 10
                context.setFillColor(UIColor.black.cgColor)

                let borderline1 = CGRect(x: (frame.width / 2) - (width / 2) - width3, y: y1, width: width3, height: (frame.height - eclipseHeight2) / 2)
                let borderline2 = CGRect(x: (frame.width / 2) + (width / 2), y: y1, width: width3, height: (frame.height - eclipseHeight2) / 2)
                context.addRects([borderline1, borderline2])
                context.fill(borderline1)
                context.fill(borderline2)
                
            case "left":
                
//                let eclipseHeight1 = frame.height / 1.75
//                let eclipseWidth1 = frame.width / 1.75
//                let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
//                context.setFillColor(UIColor.black.cgColor)
//                context.addEllipse(in: rect2)
//                context.fillEllipse(in: rect2)
//
//                let eclipseHeight2 = frame.height / 2
//                let eclipseWidth2 = frame.width / 2
//                let rect3 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
//                context.setFillColor(colors[0])
//                context.addEllipse(in: rect3)
//                context.fillEllipse(in: rect3)
                
                let width = (frame.width / 2) - (eclipseWidth2 / 2)
                let height = frame.height / 4
                let x1:CGFloat = 0
                let y1 = ((frame.height - height) / 2)
                
                
                let rect1 = CGRect(x: x1, y: y1, width: width, height: height)
                context.setFillColor(colors[0])
                context.addRects([rect1])
                context.fill(rect1)
                
                
                
                
                let height3:CGFloat = height / 10
                context.setFillColor(UIColor.black.cgColor)

                let borderline1 = CGRect(x: x1, y: (frame.height / 2) - (height / 2) - height3, width: (frame.width - eclipseWidth2) / 2, height: height3)
                let borderline2 = CGRect(x: x1, y: (frame.height / 2) + (height / 2), width: (frame.width - eclipseWidth2) / 2, height: height3)
                context.addRects([borderline1, borderline2])
                context.fill(borderline1)
                context.fill(borderline2)
                
            case "right":
                
                
//                let eclipseHeight1 = frame.height / 1.75
//                let eclipseWidth1 = frame.width / 1.75
//                let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
//                context.setFillColor(UIColor.black.cgColor)
//                context.addEllipse(in: rect2)
//                context.fillEllipse(in: rect2)
//
//                let eclipseHeight2 = frame.height / 2
//                let eclipseWidth2 = frame.width / 2
//                let rect3 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
//                context.setFillColor(colors[0])
//                context.addEllipse(in: rect3)
//                context.fillEllipse(in: rect3)
                
                let width = (frame.width / 2)
                let height = frame.height / 4
                let x1:CGFloat = (frame.width / 2) + (eclipseWidth2 / 2)
                let y1 = ((frame.height - height) / 2)
                
                
                let rect1 = CGRect(x: x1, y: y1, width: width, height: height)
                context.setFillColor(colors[0])
                context.addRects([rect1])
                context.fill(rect1)
                
                
                let height3:CGFloat = height / 10
                context.setFillColor(UIColor.black.cgColor)

                let borderline1 = CGRect(x: x1, y: (frame.height / 2) - (height / 2) - height3, width: (frame.width - eclipseWidth2) / 2, height: height3)
                let borderline2 = CGRect(x: x1, y: (frame.height / 2) + (height / 2), width: (frame.width - eclipseWidth2) / 2, height: height3)
                context.addRects([borderline1, borderline2])
                context.fill(borderline1)
                context.fill(borderline2)
                
                
                
            default:
                
                break
            
            }
            
            
            
            
            
            if isLocked == true {

                setLock(context: context)
            }
            
            
            
//            let w = frame.width / 10 * 9
//            let h = frame.height / 10 * 9
//            let x = (frame.width - w) / 2
//            let y = (frame.height - h) / 2
//            let rect1 = CGRect(x: x, y: y, width: w, height: h)
//            context.setFillColor(colors[0])
//            context.addRects([rect1])
//            context.fill(rect1)
//
//            if isLocked == true {
//
//                setLock(context: context)
//            }
            
            
//        case .exit:
//
//            //TODO: NEED TO Give this the proper look. Also need to hook this up for when the ball noves.
//
//            let w = frame.width / 10 * 9
//            let h = frame.height / 10 * 9
//            let x = (frame.width - w) / 2
//            let y = (frame.height - h) / 2
//            let rect1 = CGRect(x: x, y: y, width: w, height: h)
//            context.setFillColor(colors[0])
//            context.addRects([rect1])
//            context.fill(rect1)
//
//            if isLocked == true {
//
//                setLock(context: context)
//            }
            
            
            
        case .wall:
            
            //Need to make a dark border color around it
            
            let w = frame.width / 10 * 9
            let h = frame.height / 10 * 9
            let x = (frame.width - w) / 2
            let y = (frame.height - h) / 2
            let rect1 = CGRect(x: x, y: y, width: w, height: h)
            context.setFillColor(UIColor.darkGray.cgColor)
            context.addRects([rect1])
//            context.addEllipse(in: rect1)
            
            context.fill(rect1)

            if isLocked == true {

                setLock(context: context)
            }
            
//            layer.cornerRadius = h / 2
//            clipsToBounds = true

            
            
        case .pieceMaker:
            
            let w = frame.width / 10 * 6
            let h = frame.height / 10 * 6
            let x = (frame.width - w) / 2
            let y = x

            let rect1 = CGRect(x: x, y: y, width: w, height: h)
            context.setFillColor(colors[0])
            context.addRects([rect1])
            context.fill(rect1)

//            if isLocked == true {
//
//                setLock(context: context)
//            }
            
//            version = 4
                        
            
            switch version {
            case 1:
                print("VERSION 1")
                //Spits a new piece out of the bottom
                
                
                let point1 = CGPoint(x: x, y: h + y)
                let point2 = CGPoint(x: 0, y: frame.height)
                let point3 = CGPoint(x: frame.width, y: frame.height)
                let point4 = CGPoint(x: frame.width - (x), y: h + y)

                context.beginPath()
                context.move(to: point1)
                context.addLine(to: point2)
                context.addLine(to: point3)
                context.addLine(to: point4)
                context.closePath()
                context.setFillColor(colors[0])
                context.fillPath()
            
//                let rect = CGRect(x: x, y: y + h, width: w, height: y)
//                context.addRect(rect)
//                context.setFillColor(UIColor.black.cgColor)
//                context.fill(rect)
                
                
                
            case 2:
                print("VERSION 2")
            //Spits a new piece out of the left

                
                let point1 = CGPoint(x: frame.width - (x + w), y: y)
                let point2 = CGPoint(x: 0, y: 0)
                let point3 = CGPoint(x: 0, y: frame.height)
                let point4 = CGPoint(x: frame.width - (x + w), y: frame.height - ((y)))
                    
                
                
                
                
                context.beginPath()
                context.move(to: point1)
                context.addLine(to: point2)
                context.addLine(to: point3)
                context.addLine(to: point4)
                context.closePath()
                context.setFillColor(colors[0])
                context.fillPath()

                
                
            case 3:
                print("VERSION 3")

            //Spits a new piece out of the top

                let point1 = CGPoint(x: x, y: frame.height - (h + y))
                let point2 = CGPoint(x: 0, y: 0)
                let point3 = CGPoint(x: frame.width, y: 0)
                let point4 = CGPoint(x: frame.width - (x), y: frame.height - (h + y))
                
                context.beginPath()
                context.move(to: point1)
                context.addLine(to: point2)
                context.addLine(to: point3)
                context.addLine(to: point4)
                context.closePath()
                context.setFillColor(colors[0])
                context.fillPath()
            
            
            case 4:
                print("VERSION 4")
            //Spits a new piece out of the right
                
                
                let point1 = CGPoint(x: x + w, y: y)
                let point2 = CGPoint(x: frame.width, y: 0)
                let point3 = CGPoint(x: frame.width, y: frame.height)
                let point4 = CGPoint(x: x + w, y: frame.width - (y))
                
                
                context.beginPath()
                context.move(to: point1)
                context.addLine(to: point2)
                context.addLine(to: point3)
                context.addLine(to: point4)
                context.closePath()
                context.setFillColor(colors[0])
                context.fillPath()
            
            
            
            default:
                break
            }
            
            //Show Next Piece
        
        
        //WORK ON GETTING THE NEXT PIECES VIEW HERE. USE NEXTPIECE VAR. SEE IF ITS BEING SET. THE CODE BELOW IS WHAT IS USED IN THE VC CURRENTLY FOR THE NEXT PIECE FRAME-WISE
        
        
            
            let w2 = frame.width / 10 * 5
            let h2 = frame.height / 10 * 5
            let x2 = (frame.width - w2) / 2
            let y2 = x2

        
            let frameX = CGRect(x: x2, y: y2, width: w2, height: h2)
            
            let nextPieceView = ShapeView(frame: frameX, piece: nextPiece!)
//            nextPieceView.center = center
            
            addSubview(nextPieceView)
            
            
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
        let eclipseHeight1 = frame.height / 4
        let eclipseWidth1 = frame.width / 4
        let rect1 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
        context.addEllipse(in: rect1)
        context.setFillColor(UIColor.black.cgColor)
        context.fillEllipse(in: rect1)
    
        let eclipseHeight2 = frame.height / 5
        let eclipseWidth2 = frame.width / 5
        let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
        context.addEllipse(in: rect2)
        context.setFillColor(UIColor.white.cgColor)
        context.fillEllipse(in: rect2)
        
        
        
        
    }
    
}

enum Shape {
    
    case elbow
    case diagElbow
    case cross
    case stick
    case regular
    case ball
    
    case entrance
    case exit
    case wall
    case pieceMaker
    
    
}





